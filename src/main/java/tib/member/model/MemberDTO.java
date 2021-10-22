package tib.member.model;


public class MemberDTO {

	private int midx;
	private String mname;
	private String mid;
	private String mpwd;
	private String memail;
	private String mtel;
	private int univcode;
	private int usable; 
	private String joindate;
	private String certification;
	
	public MemberDTO() {
		// TODO Auto-generated constructor stub
	}

	public MemberDTO(int midx, String mname, String mid, String mpwd, String memail, String mtel, int univcode,
			int usable, String joindate, String certification) {
		super();
		this.midx = midx;
		this.mname = mname;
		this.mid = mid;
		this.mpwd = mpwd;
		this.memail = memail;
		this.mtel = mtel;
		this.univcode = univcode;
		this.usable = usable;
		this.joindate = joindate;
		this.certification = certification;
	}

	public int getMidx() {
		return midx;
	}

	public void setMidx(int midx) {
		this.midx = midx;
	}

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getMpwd() {
		return mpwd;
	}

	public void setMpwd(String mpwd) {
		this.mpwd = mpwd;
	}

	public String getMemail() {
		return memail;
	}

	public void setMemail(String memail) {
		this.memail = memail;
	}

	public String getMtel() {
		return mtel;
	}

	public void setMtel(String mtel) {
		this.mtel = mtel;
	}

	public int getUnivcode() {
		return univcode;
	}

	public void setUnivcode(int univcode) {
		this.univcode = univcode;
	}

	public int getUsable() {
		return usable;
	}

	public void setUsable(int usable) {
		this.usable = usable;
	}

	public String getJoindate() {
		return joindate;
	}

	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}

	public String getCertification() {
		return certification;
	}

	public void setCertification(String certification) {
		this.certification = certification;
	}
	
}
