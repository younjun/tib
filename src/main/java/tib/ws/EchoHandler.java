package tib.ws;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

import javax.servlet.Servlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class EchoHandler extends TextWebSocketHandler{
   
   Map<String,ArrayList> map = new HashMap<String,ArrayList>(); 				// key : pcode value : 해당 프로젝트 멤버의 memberdto 세션
																				// 프로젝트 멤버의 정보를 ArrayList로 담아 가변적으로 대응한다.	
   Map<String,ArrayList> chatcontent = new HashMap<String,ArrayList>();			// 프로젝트 별 채팅 내용을 저장할 map
   
   public String projectNum;

   public EchoHandler() {
   }
   
   /* #afterConnectionEstablished
    * websocket 연결 시 호출 되는 기능 (onOpen함수 실행)
    * 유저가 채팅방에 들어오는 순간 처음 호출되는 메서드이다.
    * 해당 프로젝트 채팅방에서의 이전 대화내용을 불러온다.
    * */
   @Override
   public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	   																					
      Map<String,Object> tmpSession = session.getAttributes();							// ws-config.xml 에서 handshake-interceptors 설정 후 httpSession 사용가능
      	projectNum = (String)tmpSession.get("projectNum");								// session.getAttributes();는 현재 세션의 올라간 모든 세션들을 map 형식으로 반환해준다.
      	String abspath = (String)tmpSession.get("abspath");								// projectController의 chat.do 메서드에서 세션에 등록해준 pcode와 유저의 경로를 사용하기 위함이다.
      
      ArrayList<WebSocketSession> arr = map.get(projectNum);							//멤버변수인 map에 등록되지 않은 프로젝트인 경우 webSocketSession을 담아줄 빈 ArrayList를 만들어
      if(arr==null||arr.size()==0) {													//map에 key : pcode value : ArrayList 를 등록한다.
         arr = new ArrayList<WebSocketSession>();
         map.put(projectNum, arr);
      }
      map.get(projectNum).add(session);													//map 에 등록된 key : pcode 에 해당하는 value인 ArrayList에 유저의 session 을 add 해준다.				
      
      ArrayList<String> arr2 = chatcontent.get(projectNum);								//위와 동일하게 chatcontent map이 비어있을 경우 pcode를 key로, 빈 ArrayList 를 value로 등록해준다.
      if(arr2==null||arr2.size()==0) {
         arr2 = new ArrayList<String>();
         chatcontent.put(projectNum, arr2);
      }
      
      File f = new File(abspath);														//채팅 내용을 저장하기 위해 파일 객체를 생성 abspath는 projectController에서 가져오는 값이다.(해당 유저의 경로)
      if(!f.exists()) {																	//해당 경로의 파일 유무를 검사하여 없는 경우 폴더를 생성
         f.mkdir();
      }
      
      File file = new File(abspath+"/chat"+projectNum+".txt");							//해당 경로에 pcode.txt 파일을 생성한다.
      if(!file.exists()) {																//이 파일에는 해당 프로젝트의 대화내용이 텍스트로 저장된다.
         file.createNewFile();													
      }
   
   }
   
   /* #handleTextMessage
    * webSocket.send() 호출시 실행 되는 기능
    * */
   @Override
   protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {      
      
      Map<String,Object> tmpSession = session.getAttributes();
      	projectNum = (String)tmpSession.get("projectNum");
      	String abspath = (String)tmpSession.get("abspath");

      File file = new File(abspath+"/chat"+projectNum+".txt");										//afterConnectionEstablished() 에서 저장한 파일을 읽기 위해 파일 객체를 생성한다.
      
      if(chatcontent.get(projectNum).size()>30) {      
         try {
            BufferedWriter writer = new BufferedWriter(new FileWriter(file,true));                 //해당 텍스트 파일에 추가 하기 위해 BufferdWriter 객체 생성 (true는 이어쓰기,false는 덮어쓰기) 
            PrintWriter pw = new PrintWriter(writer,true);										   //불러온 파일에 글을 작성하기 위한 BufferedWriter 를 담고 있는 PrintWriter 생성 (true는 이어쓰기,false는 덮어쓰기) 
            
            for(int i=0; i<chatcontent.get(projectNum).size(); i++) {							   //채팅 내용을 담고있는 ArrayList의 사이즈 만큼 for문을 반복해 list의 요소를 한줄 씩 불러온 파일에 이어서 저장 
               pw.write((String)chatcontent.get(projectNum).get(i)+"\n");
            }
            writer.close();																		   //파일에 글쓰기가 종료된 후 BufferedWriter와 PrintWriter를 닫아준다.
            pw.close();
         }catch(IOException e) {
            e.printStackTrace();
         }
         chatcontent.get(projectNum).clear(); 													   //ArrayList안 요소를 모두 파일에 저장 후 ArrayList를 비워준다.
      }
      
      if(message.getPayload().equals("Enter the chat room")&&file.exists()) {						//유저가 채팅방에 들어올 경우 onOpen이 실행되며 Enter the chat room을 자동으로 send한다
    	  																							//handleTextMessage 메서드가 수행되며 불러온 파일안에 저장되어있는 글을 불러와 list에  라인을 기준으로 저장한다. 		
         List<String> list = Files.readAllLines(Paths.get(abspath+"/chat"+projectNum+".txt"), StandardCharsets.UTF_8);
         for (String line : list) { 																//list 요소만큼 for문을 반복하며 입장한 유저에게 요소를 차례대로 send해준다.
            session.sendMessage(new TextMessage(line));
         }
         for(int i=0; i<chatcontent.get(projectNum).size(); i++) {									//ArrayList에 저장되어있는 %30 채팅도 send 해준다.
            String text = (String)chatcontent.get(projectNum).get(i);
            session.sendMessage(new TextMessage(text));
         }
      }else if((!message.getPayload().equals("Enter the chat room"))){                              //해당 유저가 채팅방 입장 후 채팅 내용을 입력했을 경우 
         chatcontent.get(projectNum).add(message.getPayload());										//해당 방번호로 방에있는 세션값들을 얻어와 send
         																							//현재 같은 프로젝트 채팅방에 접속되어있는 유저 들에게만 내가 보낸 메세지를 모두 send해준다. 
         for(int i=0; i<map.get(projectNum).size(); i++) {
            WebSocketSession s = (WebSocketSession)map.get(projectNum).get(i);
            s.sendMessage(new TextMessage(message.getPayload()));
         }
      }
      
   }
   /* #afterConnectionClosed
    * 채팅방 페이지를 나가는 경우 websocket 연결이 끊긴다.
    * 연결이 끊긴 경우 호출되는 기능
    * */
   @Override
   public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
      Map<String,Object> tmpSession = session.getAttributes();
      projectNum = (String)tmpSession.get("projectNum"); 											//projectNum을 key값으로 가지고 있는 session을 멤버변수로 선언되어있는 projectNum 변수에 넣는다. 
      map.get(projectNum).remove(session);  														//해당 유저의 session을  해당 프로젝트의 ArrayList에서 remove해준다. 
   }
   
}