package tib.file.model;

import java.util.ArrayList;
import java.util.HashMap;

public interface FileDAO {

	public int saveFile(FileDTO dto);
	public int fileTotalSize(String pcode);
	public ArrayList getFileList(HashMap map);
	public FileDTO getFileDTO(int didx);
	public int deleteFile(int didx);
	public ArrayList profileFileList(HashMap projectMember);
}
