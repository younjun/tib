package tib.file.model;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;

public class FileDAOImple implements FileDAO {
   
   private SqlSessionTemplate sst;
   
   public FileDAOImple(SqlSessionTemplate sst) {
      super();
      this.sst = sst;
   }

   /**
    * #saveFile
    * 파일 정보 DB저장 관련 메서드 
    * */
   public int saveFile(FileDTO dto) {
      
      sst.insert("saveFile",dto);
      
      return 0;
   }
   
   /**
    * #fileTotalSize 
    * 파일 갯수 관련 메서드 
    * */
   public int fileTotalSize(String pcode) {
      
      int totalSize = sst.selectOne("fileTotalSize", pcode);
      
      return totalSize;
   }
   
   /**
    * #getFileList
    * 파일 목록 (페이징처리) 관련 메서드 
    * */
   public ArrayList getFileList(HashMap map) {
      
      ArrayList al = (ArrayList)sst.selectList("getFileList",map);  //시작 rownum과 끝 rownum을 담은 map객체를 넘겨 파일 목록 불러오기
       
      return al;
   }
   
   /**
    * #getFileDTO
    * 해당 파일 정보 관련 메서드 
    * */
   public FileDTO getFileDTO(int didx) {
      
      FileDTO dto = sst.selectOne("getFileDTO", didx);
      
      return dto;
   }
   
   /**
    * #deleteFile
    * 파일 삭제 시 DB에 있는 파일 정보 삭제 관련 메서드 
    * */
   public int deleteFile(int didx) {
      
      sst.delete("deleteFileDB",didx);
      
      return 0;
   }

   /**
    * #profileFileList
    * 프로필 모달 관련 파일 목록 메서드 
    * */
   public ArrayList profileFileList(HashMap projectMember) {
         
      ArrayList<FileDTO> arr = (ArrayList)sst.selectList("profileFileList",projectMember);
         
      return arr;
   }
}