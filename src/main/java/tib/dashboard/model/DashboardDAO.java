package tib.dashboard.model;

import java.util.List;

import tib.calendar.model.scheduleDTO;
import tib.member.model.MemberDTO;

public interface DashboardDAO {
   public String proMemList(int pidx);
   public String workamount(int pidx);
   public List<scheduleDTO> cardTInfo(int pidx);
   public List<scheduleDTO> cardMInfo(int pidx);

}