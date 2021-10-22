package tib.project.model;
import java.util.*;
public interface ProjectDAO {

	   public String addProject(ProjectDTO dto);
	   public ArrayList<ProjectDTO> projectList(int midx);
	   public int addProjectMember(int pidx,int midx);
	   public ProjectDTO projectInfo(String pcode);
	   public int exitProjectHost(int pidx);
	   public int exitProjectMember(int pidx,int midx);
	   public List publicProject();
	   public int projectMemberCheck(int pidx,int midx);
	   public void countPlus(int pidx);
	   public void countMinus(int pidx);
	   public ArrayList<ProjectDTO> allProjectList(HashMap map);
	   public int countProject();
	   public int okPcode(String pcode, int pidx);
}
