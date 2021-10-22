package tib.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.CharacterData;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import tib.faq.model.FaqDAO;
import tib.faq.model.FaqDTO;
import tib.member.model.MemberDAO;
import tib.member.model.MemberDTO;
import tib.page.PageModule;
import tib.project.model.ProjectDAO;
import tib.project.model.ProjectDTO;
import tib.services.model.ServicesDAO;
import tib.services.model.ServicesDTO;
import tib.univ.model.UnivDAO;
import tib.univ.model.UnivDTO;

@Controller
public class AdminController {

      @Autowired
      UnivDAO univDao; 
      
      @Autowired
      MemberDAO memberDao;
      
      @Autowired
      ProjectDAO projectDao;
      
      @Autowired
      private FaqDAO faqDao;
      
      @Autowired
      private ServicesDAO servicesDao;
      
      static public int LISTSIZE = 10;
      static public int PAGESIZE = 5;
      
      /**
       * #addUnivForm
       * 어드민 indexTib 제휴대학 추가 페이지로 이동 메서드 */
      @RequestMapping(value="/addUniv.do", method = RequestMethod.GET)
      public String addUnivForm() {
         return "admin/addUniv";
      }
      
      /**
       * #addUniv
       * addUniv.jsp에서 제휴대학 정보 입력 후 추가 버튼클릭시 호출되는 명령어  */
      @RequestMapping(value="/addUniv.do", method = RequestMethod.POST)
      public ModelAndView addUniv(UnivDTO dto) {
         ModelAndView mav = new ModelAndView();
         
         int result = univDao.addUniv(dto);                             //form 태그 name값 매칭으로 받아온 UnivDTO dto를 DTOImple(addUniv)를 이용하여 DB에 insert 
         
         if(result>0) {
            mav.setViewName("admin/addUniv");                           //insert가 정상적으로 수행 시  수행했던 원래 페이지로 이동 
         }
         
         return mav; 
      }
      
      /**
       * #adminIndex();
       * 로그인 시 id값으로 관리자 검증 후 관리자라면 관리자 페이지로 이동시켜주는 명령어  */
      @RequestMapping("/indexAdmin.do")
      public String adminIndex() {
         return "admin/indexAdmin"; 
      }
      
      /**
       * #adminMemberList
       * 관리자 메뉴 (회원정보 관리) 선택시 회원 목룍 및 페이징 처리 메서드 */
      @RequestMapping("/allMemberInfo.do")
      public ModelAndView adminMemberList(@RequestParam(value = "nowpage", defaultValue = "1")int nowpage) {
         ModelAndView mav = new ModelAndView();
        
         HashMap<String,Integer> pagemap = new HashMap<String,Integer>();                                   //페이징 처리를 위한 시작 rownum 과 끝 rownum을 담을 map
            int start = ((nowpage-1)*LISTSIZE+1);                                  
            int end = nowpage*LISTSIZE;       
               pagemap.put("start",start);
               pagemap.put("end",end);
                   
          ArrayList<MemberDTO> list = (ArrayList)memberDao.memberList(pagemap);                              //해당 페이지에 해당하는 목록을 memberDao를 이용하여 받아준다.
         
          int membercount = memberDao.countMember();                                                         //페이징 처리를 위한 총 회원의 수를 받아오는 메서드 
            String paging = tib.page.PageModule.pageMake("allMemberInfo.do", 
                  membercount, LISTSIZE, PAGESIZE, nowpage);                                               //페이징 모듈을 이용하여  페이징 처리 HTML문을 담고있는 String변수
        
         mav.addObject("cp",nowpage); 
         mav.addObject("paging",paging);
         mav.addObject("memberList",list); 
         
         mav.setViewName("admin/allMemberInfo");
         
         return mav; 
      }
     
      /**
       * #updateUnivForm
       * 제휴대학 관리 페이지 이동 관련 메서드 
       * */
      @RequestMapping(value = "/updateUniv.do",method = RequestMethod.GET)
      public ModelAndView updateUnivForm() {
          
         ModelAndView mav = new ModelAndView();
         
         ArrayList<UnivDTO> univs = univDao.getUnivList();               //DB에 저장되어 있는 모든 학교 목록 관련 
         
         mav.addObject("univs", univs);
         mav.setViewName("admin/updateUniv");
         
         return mav;
      }
      
      /**
       * #updateUniv
       * updateUniv.jsp 에서 정보 수정 입력 후 DB에  UPDATE문 실행 관련 메서드 
       * */
      @RequestMapping(value = "/updateUniv.do",method = RequestMethod.POST)
      public ModelAndView updateUniv(UnivDTO dto) {
        
         ModelAndView mav = new ModelAndView(); 
        
         int result = univDao.updateUniv(dto);                            //넘어온 UnivDTO 객체를 이용하여  DB에 UPDATE쿼리 실행
             if(result>0) {
                mav.addObject("msg","수정완료");                            
                mav.addObject("goUrl","updateUniv.do");
             }
        
         mav.setViewName("admin/adminMsg");
       
         return mav;
      }
      
      /**
       * #univInfo
       * 회원 목록 중 대학 코드 클릭시 모달에 보여줄
       * */
      @RequestMapping("/univInfo.do")
      public ModelAndView univInfo(@RequestParam("univcode")int univCode) {
        
         ModelAndView mav = new ModelAndView();                           
            
         UnivDTO dto = univDao.univInfo(univCode);                         //파라미터 값으로 받은 univCode를 식별자로 DB로부터 해당 제휴대학정보 객체 생성 
            dto.setUstartdate(dto.getUstartdate().substring(0,11));          //계약일과 만료일을 단순 String타입으로 보여주기 위해 날짜 까지만 저장
            dto.setUenddate(dto.getUenddate().substring(0,11));            
         
         mav.addObject("dto",dto);
         mav.setViewName("tibJson");                                       //json을 이용하여 해당 객체를 저장 (ajax 처리에 대한 callBack함수에서 데이터를 사용하기 위함)
        
         return mav;
      }
      
      /**
       * #admin_All_pojectInfo
       * 관리자 메뉴 프로젝트 관리 페이지 이동 관련 메서드
       * */
      @RequestMapping("/AllprojectInfo.do")
      public ModelAndView admin_All_pojectInfo(@RequestParam(value = "cp", defaultValue = "1")int nowpage) {
         
         ModelAndView mav =new ModelAndView();
         
         HashMap<String,Integer> pagemap = new HashMap<String,Integer>();                                   //페이징 처리를 위한 시작 rownum 과 끝 rownum을 담을 map 
            int start = ((nowpage-1)*LISTSIZE+1); 
            int end = nowpage*LISTSIZE;      
               pagemap.put("start",start);
               pagemap.put("end",end);
         
         ArrayList<ProjectDTO> projectList = projectDao.allProjectList(pagemap);                            //해당 페이지에 페이지 목록을 담아준다.
         
         int projectCount = projectDao.countProject();                                                      //페이징 처리를 위한 총 프로젝트 count를 DB로 부터 받아온다
            String paging = tib.page.PageModule.pageMake("AllprojectInfo.do", 
                  projectCount, LISTSIZE, PAGESIZE, nowpage);                                              //페이징 모듈을 이용하여  페이징 처리 HTML문을 담고있는 String변수
         
         mav.addObject("cp",nowpage);
         mav.addObject("paging",paging);
         mav.addObject("projectList",projectList);
         mav.setViewName("admin/projectList");
         
         return mav;
         
      }
      
      /**
       * #projectInfo_modal
       * 프로젝트 모달에 뿌려줄 정보를 받아오기 위한 메서드 
       * */
      @RequestMapping("/projectInfo.do")
      public ModelAndView projectInfo_modal(@RequestParam("pcode")String pcode,@RequestParam("pidx")int pidx) {
        
         ModelAndView mav  = new ModelAndView();         
        
         ProjectDTO dto = projectDao.projectInfo(pcode);                                                       //받아온 pcode를 식별자로 해당 project객체 생성
         
         ArrayList<MemberDTO> arr = (ArrayList)memberDao.projectMemberInfo(pidx);                              //해당 프로젝트에 참여되어있는 멤버들의 정보
         
         mav.addObject("project",dto);
         mav.addObject("memberList",arr);
         mav.setViewName("tibJson");
         
         return mav; 
      }
     
      /**
       * #admin_certification
       * 관리자의 임의 회원이메일 인증 여부 처리 관련 메서드 
       * */
      @RequestMapping("/change_certification.do")
      public ModelAndView admin_certification(@RequestParam("midx")int midx) {
       
        ModelAndView mav = new ModelAndView(); 
        
        int result = memberDao.updateCertification(midx);                     //받아온  midx를 식별자로 DB 에서 해당  멤버의 이매일 인증 여부를 UPDATE
       
        mav.setViewName("redirect:allMemberInfo.do");                         //다시 회원 목록을 받아오기 위해 redirect를 이용하여 해당 명령어 수행 
        
        return mav;
      }
     
      /**
       * #admin_getMemberInfo
       * */
      @RequestMapping("/memberInfo.do")
      public ModelAndView admin_getMemberInfo(@RequestParam("mid")String mid) {
        
         ModelAndView mav = new ModelAndView(); 
        
         MemberDTO dto = memberDao.memberInfo(mid);                            //mid를 식별자로 DB로부터 멤버 정보를 받아온다.
         
          UnivDTO udto = univDao.univInfo(dto.getUnivcode());                   //받아온 멤버 정보에 univCode를 이용하여 학교 정보를 DB로부터 받아옴
            if(udto==null) {
               udto = new UnivDTO();
               udto.setUname("학교 없음");
            }
         
         
         mav.addObject("mdto",dto);
          mav.addObject("udto",udto);     
          
          mav.setViewName("tibJson");                                           //json을 이용하여 해당 객체를 저장 (ajax 처리에 대한 callBack함수에서 데이터를 사용하기 위함)
         
          return mav; 
      }
     
      /**
       * #admin_deleteMember
       * 회원 삭제 관련 메서드 
       * */
      @RequestMapping("/deleteMember.do")
      public ModelAndView admin_deleteMember(@RequestParam("midx")int midx) {
       
         ModelAndView mav = new ModelAndView(); 
          
         int result = memberDao.deleteMember(midx);                         //midx를 식별자로 DB로부터 해당 회원을 삭제한다. 
       
         if(result>0) {       
            mav.addObject("msg","회원을 삭제하였습니다.");      
            mav.addObject("goUrl","allMemberInfo.do");      
            mav.setViewName("admin/adminMsg");           
         }
          
         return mav;
      }
     
      /**
       * #admin_deleteUniv
       * 제휴대학 관리 중 제휴대학 삭제 관련 메서드 
       * */
      @RequestMapping("/deleteUniv.do")
      public ModelAndView admin_deleteUniv(@RequestParam("univCode")int univCode) {
         
         ModelAndView mav = new ModelAndView();
         
         int result = univDao.deleteUniv(univCode);                               //univCode를 식별자로 해당학교를 DB로부터 삭제한다. 
        
        
         if(result>0) {
              mav.addObject("msg","계약을 해지하였습니다."); 
              mav.addObject("goUrl","updateUniv.do"); 
              mav.setViewName("admin/adminMsg");
          }
        
         return mav; 
      }
      
      /**
       * #getElementValue
       * 전국 대학 정보 관련	
       * */
      private static String getElementValue(Element e) {
          Node child = e.getFirstChild();
          if(child instanceof CharacterData) {
              CharacterData data = (CharacterData) child;
              return data.getData();
          }
          return "-";
      } 
     
      /**
       * #domesticUnivList
       * */
      @RequestMapping(value="/domesticUnivList.do",method=RequestMethod.GET)
      public ModelAndView domesticUnivList(@RequestParam(value="cp",defaultValue = "1")int cp) {
       
        ModelAndView mav = new ModelAndView();
       
        File file = new File("D:\\hyun\\venti\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\venti5\\univs//domesticUnivList.txt"); //해당 경로에 파일객체 생성
           String str="";
         StringBuffer sb = new StringBuffer();
         String line="";
         BufferedReader br=null;
         
        try {
             br = new BufferedReader(new FileReader(file));
            while((line=br.readLine())!=null) {
               sb.append(line);
            }
            str=sb.toString();
            br.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
         
        str=str.replaceAll("\ufeff", "");                                                      //파잃형식 지정자 빈문자열로 셋팅
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        DocumentBuilderFactory df = DocumentBuilderFactory.newInstance();                      //XML파일을 자바 객체화 시켜주기 위한 객체 
        DocumentBuilder db;
         
         
       int totalCnt=0;
       
       try {
          
          db=df.newDocumentBuilder();
            
          InputSource inputSource = new InputSource(new StringReader(str));
          inputSource.setCharacterStream(new StringReader(str));
          
          Document domParsed = db.parse(inputSource);                                         //InputSource 를 DOM객체로 파싱
          NodeList rowList = domParsed.getElementsByTagName("row");
          
          totalCnt=rowList.getLength();
          
          for(int i=0;i<rowList.getLength();i++) {                                           //반복문을 이용하여 해당 DOM객체를 노드별 MPA객체에 PUT
             
               Element element=(Element)rowList.item(i);
               Element utype=(Element)element.getElementsByTagName("utype").item(0);
               Element local=(Element)element.getElementsByTagName("local").item(0);
               Element name=(Element)element.getElementsByTagName("name").item(0);
               Element nameEn=(Element)element.getElementsByTagName("nameEn").item(0);
               Element campus=(Element)element.getElementsByTagName("campus").item(0);
               Element state=(Element)element.getElementsByTagName("state").item(0);
               Element state2=(Element)element.getElementsByTagName("state2").item(0);
               Element zip=(Element)element.getElementsByTagName("zip").item(0);
               Element addr=(Element)element.getElementsByTagName("addr").item(0);
               Element tel=(Element)element.getElementsByTagName("tel").item(0);
               Element fax=(Element)element.getElementsByTagName("fax").item(0);
               Element web=(Element)element.getElementsByTagName("web").item(0);
      
               Map<String,Object> univs = new HashMap<String,Object>();
      
               univs.put("utype",getElementValue(utype));
               univs.put("local",getElementValue(local));
               univs.put("name",getElementValue(name));
               univs.put("nameEn",getElementValue(nameEn));
               univs.put("campus",getElementValue(campus));
               univs.put("state",getElementValue(state));
               univs.put("state2",getElementValue(state2));
               univs.put("zip",getElementValue(zip));
               univs.put("addr",getElementValue(addr));
               univs.put("tel",getElementValue(tel));
               univs.put("fax",getElementValue(fax));
               univs.put("web",getElementValue(web));
               
               list.add(univs);
            
           }
        } catch (ParserConfigurationException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        } catch (SAXException e) {
           // TODO Auto-generated catch block
          e.printStackTrace();
        } catch (IOException e) {
         // TODO Auto-generated catch block
           e.printStackTrace();
        } 
      
            int start=((cp-1)*10);
            int end=cp*10-1;
         
        ArrayList list2 = new ArrayList();
       
        for(int i=start;i<=end;i++) {
             try {
                list2.add(list.get(i));
             }catch(Exception e) {
                break; 
             }
           
        }
       
        PageModule pm = new PageModule();    
         String page = pm.pageMake("domesticUnivList.do", totalCnt, 10, 10, cp);
       
         mav.addObject("page", page);
         mav.addObject("univs", list2);
         mav.setViewName("admin/domesticUnivList");
        
         return mav;
      }
      
      /**
       * #mainIndexAdmin
       * */
      @RequestMapping("/mainIndexAdmin.do")
      public ModelAndView mainIndexAdmin() {
         
         ModelAndView mav = new ModelAndView();
         
         List lists = faqDao.faqAllList();
             
         mav.addObject("lists", lists);
          mav.setViewName("admin/mainIndexAdmin");
        
         return mav;
      }
     
      /**
       * #addFaq
       * 관리자의 질문 및 답변 insert문 관련 메서드 
       * */
      @RequestMapping("/addFaq.do")
      public String addFaq(FaqDTO fdto) {
        
         faqDao.addFaq(fdto);
         
         return "redirect:/mainIndexAdmin.do";
      }
     
      /**
       * #updateFaq
       * 관리자의 질문 및 답변 수정 관련 메서드 
       * */
      @RequestMapping("/faqUpdate.do")
      public String updateFaq(FaqDTO fdto) {
        
         faqDao.faqUpdate(fdto);
         
         return "redirect:/mainIndexAdmin.do";
      }
     
      /**
       * #deleteFaq
       *  관리자의 질문 및 답변 삭제 관련 메서드 
       * */
      @RequestMapping("/faqDel.do")
      public String deleteFaq(@RequestParam("fidx")int fidx) {
         
         faqDao.faqDelete(fidx);
         
         return "redirect:/mainIndexAdmin.do";
      }
      
      /**
       * #mainIndexAdmin2
       * */
      @RequestMapping("/mainIndexAdmin2.do")
      public ModelAndView mainIndexAdmin2(ServicesDTO sdto,HttpServletRequest req) {
        
         ModelAndView mav = new ModelAndView();
         
         List slists = servicesDao.servicesAllList();                              //DB로부터 메인에 보여줄 광고글,사진 이름목록을 받아온다.
             
          mav.addObject("slists", slists);
          mav.setViewName("admin/mainIndexAdmin2");
         
          return mav;
      }
     
      /**
       * #updateServices
       * 사용자에게 보여줄 광고글,사진 등 수정 관련 메서드 
       * */
      @RequestMapping(value = "/servicesUpdate.do", method = RequestMethod.POST)
      public ModelAndView updateServices(ServicesDTO sdto,HttpServletRequest req,@RequestParam("imgUpload")MultipartFile imgUpload) {
         
         ModelAndView mav = new ModelAndView();
        
         copyInto(imgUpload, req, sdto.getSidx());                                                                                  //업로드된 파일을 복사
         
         sdto.setSimg(imgUpload.getOriginalFilename());                                                                             //수정하기 위해 넘어온 ServicesDTO 객체의 IMG이름을 받아온 파일의 이름으로 셋
          servicesDao.servicesUpdate(sdto);                                                                                          //UPDATE문 실행 
        
         
          mav.setViewName("redirect:/mainIndexAdmin2.do");
        
          return mav;
      }
     
      /**
       * #copyInfo
       * */
      private void copyInto(MultipartFile upload,HttpServletRequest req,int sidx) {
      
           String filePath = req.getRealPath("/tib_img/"+sidx+"/");
          
           try {                                                                        //복사 기본 코드
              byte bytes[] = upload.getBytes();                                         //원본 파일 가져오기
              File outFile = new File(filePath+upload.getOriginalFilename());           //빈종이 복사본 만들기 * 어떠한 상황이 발생하면 추가코드 발생 *
             
              FileOutputStream fos = new FileOutputStream(outFile);                     //글을 쓰는 행위
              fos.write(bytes);                                                         //복사 버튼
              fos.close();                                                              //더이상 쓸일 없으니 닫아주기
           } catch (IOException e) {
              e.printStackTrace();
           }
     }
      
}