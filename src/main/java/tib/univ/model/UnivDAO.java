package tib.univ.model;

import java.util.ArrayList;

public interface UnivDAO {

	 public ArrayList<UnivDTO> getUnivList();
	 public int getUnivcode(String uemail);
	 public int addUniv(UnivDTO dto);
	 public UnivDTO univInfo(int univCode);
	 public int updateUniv(UnivDTO dto);
	 public int deleteUniv(int univCode);
}
