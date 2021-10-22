package tib.calendar.model;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import org.w3c.dom.CharacterData;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



public class HolidayCrawling {


    private static String getElementValue(Element e) {
        Node child = e.getFirstChild();
        if(child instanceof CharacterData) {
            CharacterData data = (CharacterData) child;
            return data.getData();
        }
        return "-";
    }
    
    public List<Map<String,Object>> getParsedXMLResult(calendarDTO dto)throws IOException{
    
       //System.out.println(dto.getMonth());
       int date_ori = Integer.parseInt(dto.getMonth())+1;
       if(date_ori==11) {
          date_ori = 0;
       }
       String date2 = String.format( "%02d" , (date_ori) );
       //System.out.println(date2);
       
       
       StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo"); /*URL*/
           urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=NDm%2BuDttoh089ur2C7Jt7W4xFVY2KhlPLjjHn1HyHj3%2BZpCxKg%2FxkAkBvgqd9YC1crEFgIPnldfWjNZij9TX%2Fg%3D%3D"); /*Service Key*/
           urlBuilder.append("&" + URLEncoder.encode("solYear","UTF-8") + "=" + URLEncoder.encode(dto.getYear(), "UTF-8")); /*연*/
           urlBuilder.append("&" + URLEncoder.encode("solMonth","UTF-8") + "=" + URLEncoder.encode(date2, "UTF-8")); /*월*/
           URL url = new URL(urlBuilder.toString());
           HttpURLConnection conn = (HttpURLConnection) url.openConnection();
           conn.setRequestMethod("GET");
           conn.setRequestProperty("Content-type", "application/json");
           System.out.println("Response code: " + conn.getResponseCode());
           BufferedReader rd;
           if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
               rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
           } else {
               rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
           }
           StringBuilder sb = new StringBuilder();
           String line;
           while ((line = rd.readLine()) != null) {
               sb.append(line);
           }
           rd.close();
           conn.disconnect();
          // System.out.println(dto.getYear());
          // System.out.println(dto.getMonth());
          //System.out.println(sb.toString());
           String apiResult = sb.toString();
    
    // 2) XML DOM 빌드 -> List<Map<String,Object>> 변환

        List<Map<String,Object>> resultList = new ArrayList<Map<String, Object>>();

        DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder;
        try {
            builder = builderFactory.newDocumentBuilder();
            InputSource inputSource = new InputSource();
            inputSource.setCharacterStream(new StringReader(apiResult));
            Document domParsed = builder.parse(inputSource);
            NodeList itemList = domParsed.getElementsByTagName("item");

            for(int i=0; i<itemList.getLength(); i++) {
                Element element = (Element) itemList.item(i);
                Element dateKind = (Element) element.getElementsByTagName("dateKind").item(0);
                Element dateName = (Element) element.getElementsByTagName("dateName").item(0);
                Element isHoliday = (Element) element.getElementsByTagName("isHoliday").item(0);
                Element locdate = (Element) element.getElementsByTagName("locdate").item(0);
                Element seq = (Element) element.getElementsByTagName("seq").item(0);

                Map<String, Object> holiday = new HashMap<String, Object>();
                holiday.put("dateKind", getElementValue(dateKind));
                holiday.put("dateName", getElementValue(dateName));
                holiday.put("isHoliday", getElementValue(isHoliday));
                holiday.put("locdate", getElementValue(locdate));
                holiday.put("seq", getElementValue(seq));

                String day = "";
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
                LocalDate date = LocalDate.parse(holiday.get("locdate").toString(), formatter);

                int dayNum = date.getDayOfWeek().getValue();
                switch(dayNum) {
                    case 1:
                        day = "월요일";
                        break;
                    case 2:
                        day = "화요일";
                        break;
                    case 3:
                        day = "수요일";
                        break;
                    case 4:
                        day = "목요일";
                        break;
                    case 5:
                        day = "금요일";
                        break;
                    case 6:
                        day = "토요일";
                        break;
                    case 7:
                        day = "일요일";
                        break;
                }

                holiday.put("DAY_CD", String.valueOf(dayNum));
                holiday.put("DAY_NM", day);
                holiday.put("D_REG_DT", LocalDate.now().format(formatter));
                holiday.put("D_UPDATE_DT", LocalDate.now().format(formatter));
                holiday.put("BIGO", holiday.get("dateName").toString());
                holiday.put("V_TIME", holiday.get("locdate").toString());

                resultList.add(holiday);
                //System.out.println(holiday.toString());
            }
           //System.out.println(resultList.toString());

        } catch (ParserConfigurationException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      } catch (SAXException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }

        return resultList;
    }
}