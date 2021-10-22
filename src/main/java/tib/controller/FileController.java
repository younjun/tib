package tib.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import tib.file.model.FileDAO;
import tib.file.model.FileDTO;
import tib.member.model.MemberDTO;
import tib.page.PageModule;
import tib.project.model.ProjectDTO;
@Controller
public class FileController {
   
      @Autowired
      private FileDAO fileDao;
      
      PageModule paging = new PageModule();
   
      public static int LISTSIZE = 10; 
      public static int PAGESIZE = 5;
   
      /**
       * #upload
       * 
       * */
      @RequestMapping(value="/fileUpload.do",method=RequestMethod.POST)
      @ResponseBody                                                                                                     //drag and drop 관련 
      public String upload(MultipartHttpServletRequest mpreq, @RequestParam("pcode")String pcode,HttpSession session) {
         
             Iterator<String> itr = mpreq.getFileNames();                                                              //다중 업로드로 들어온 파일들의 이름을 담아준다 
            
             File dir = null;
             
             String filePath = mpreq.getRealPath("/tib_files");                                                        //프로젝트 폴더앞까지의 파일 경로 
             
             String param="";
              
              MemberDTO memberDto = (MemberDTO)session.getAttribute("user"); 
                 String mid = memberDto.getMid();
                 String mname = memberDto.getMname();
              
              while (itr.hasNext()) {                                                                                   // 받아온 파일만큰 반복문 시행 
         
                   MultipartFile mpf = mpreq.getFile(itr.next());                                                       //itr에 있는 파일의 이름으로 해당 파일을 mpf로 생성 
                      String originalFileName = mpf.getOriginalFilename();                                             //생성한 mpf의  이름을 String 변수에 저장 
                  
                   int dott = originalFileName.indexOf('.');                                                            //파일이름에 '.'이 있는 index번호를  정수형 변수에 저장  
                      String fileName=originalFileName.substring(0, dott);                                             //확장자를 제외한 파일의 이름
                      String dkind = originalFileName.substring(dott);                                                 //해당 파일의 확장자 
                     
                   String fileFullPath = filePath+"/"+pcode+"/"+fileName;                                               //실제 사용될 파일 경로
                   String fileNumber="";                                                                          
                 
                   int i=2;
                     
                   while(new File(fileFullPath+fileNumber+dkind).exists()) {                                            //업로드한 파일 이름이 이미 폴더에 있을 경우 2부터 순서대로 1씩 증가하여 괄호로 묶어 파일이름에 더해준다. 
                        
                       fileNumber="("+ i++ +")";
                   }
                  
                   fileFullPath=fileFullPath+fileNumber+dkind;                                                          //실제 사용될 파일 경로를 다시 설정
                  
                   FileDTO fdto= new FileDTO(pcode, 0, mid, mname, fileName+fileNumber, dkind, null,fileFullPath);      //업로드된 파일의 정보를담은  DTO 생성 
                   fileDao.saveFile(fdto);                                                                              //업로드된 파일정보를 DB에 insert해준다.
                  
                  
                   dir=new File(filePath+"/"+pcode);                                                                    //프로젝드 코드의 폴더가 없다면 폴더 생성 
                   if(!dir.exists()) {
                        dir.mkdir();
                      }
               
                   
               try {
                   
                       mpf.transferTo(new File(fileFullPath));                                                          //파일저장 실제로는 service에서 처리
                       
                }catch (Exception e) {
                       e.printStackTrace();
                }
                             
           }
             
            return "success";
       }
      
       /**
        * #filelist
        * 자료실 페이지로 이동관련 진입 메서드 
        * */
      @RequestMapping("/goFileList.do")
         public ModelAndView fileList(HttpServletRequest req,HttpSession session,@RequestParam(value="cp",defaultValue = "1")int cp) {
            
          ModelAndView mav = new ModelAndView();
            
          ProjectDTO pdto= (ProjectDTO)session.getAttribute("projectDTO");
            String pcode=pdto.getPcode();
            
           String filePath = req.getRealPath("/tib_files/"+pcode);                                                                    //해당 프로젝트의 파일 관리 폴더 경로       
            
           int totalCnt = fileDao.fileTotalSize(pcode);                                                                                //해당 프로젝트 파일의 총 갯수를 구해온다. ( 페이징 관련) 
             
           HashMap map = new HashMap<String, Object>();                                                                                //페이징 관련 시작rownum과 끝rownum을 담아줄 Map객체 
               map.put("pcode", pcode);
               int start=((cp-1)*LISTSIZE)+1;
               int end=cp*LISTSIZE;
               map.put("start", start);
               map.put("end", end);
                        
         ArrayList files = fileDao.getFileList(map);                                                                                  //페이징 처리를 위한map객체를 실어 파일 목록을 담아온다. 
            
         String page = paging.pageMake("goFileList.do", totalCnt, LISTSIZE, PAGESIZE, cp);                                            //페이징 모듈을 이용하여 페이징 처리를 담은 HTML문을 String변수에 저장                   
            
         mav.addObject("page", page);         
         mav.addObject("files", files);         
         mav.setViewName("file/fileList");
            return mav;
         }
      
         /**
          * #fileDown
          * 파일 클릭시 다운로드 관련 메서드 
          * */
         @RequestMapping("/fileDown.do")
         public ModelAndView fileDown(HttpServletRequest req, @RequestParam("filename")String filename,@RequestParam("projectNum")String pcode,
               @RequestParam(value="dkind",defaultValue="")String dkind) {
   
           ModelAndView mav = new ModelAndView();
            
           String filePath = req.getRealPath("/tib_files/"+pcode+"/"+filename+dkind);                                                           //해당 파일의 경로 
   
            File f = new File(filePath);                                                                                                         //해당파일의 경로로 파일 생성 
                     
            mav.addObject("downloadFile", f);                                                                                                    
            mav.setViewName("tibDown");                                                                                                          
            
            return mav;
         }
         
         /**
          * #deleteFile
          * 파일 삭제 관련 메서드 
          * */
         @RequestMapping(value="/deleteFile.do",method=RequestMethod.GET)
         public ModelAndView deleteFile(@RequestParam("didx")int didx) {
            
            ModelAndView mav = new ModelAndView();
            
            FileDTO fdto = fileDao.getFileDTO(didx);                    //didx를 식별자로 DB에서 해당 파일의 정보를 파일정보를 담는 DTO 생성
            
            String msg = ""; 
            
            if(new File(fdto.getFullName()).delete()) {                 //실제 메타데이터 폴더속 파일이 삭제가 정상적으로 수행되었는지 조건문
              
               fileDao.deleteFile(didx);                               //정상적인 수행이 이루어졌다면 DB에서 해당 파일의 정보를 delete문 
               msg=fdto.getDname()+fdto.getDkind()+" 파일이 삭제 되었습니다.";
            
            }else {
               
               msg=fdto.getDname()+fdto.getDkind()+" 파일 삭제에 실패했습니다.";
            }
            
            mav.addObject("msg", msg);
            mav.setViewName("file/fileOk");
            
            return mav;
            
         }
      
}