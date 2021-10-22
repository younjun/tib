package tib.file.model;

import java.sql.Date;

public class FileDTO {

	private String pcode;
	private int didx;
	private String mid;
	private String mname;
	private String dname;
	private String dkind;
	private java.sql.Date ddate;
	private String fullName;
	public FileDTO() {
		// TODO Auto-generated constructor stub
	}
	public FileDTO(String pcode, int didx, String mid, String mname, String dname, String dkind, Date ddate,String fullName) {
		super();
		this.pcode = pcode;
		this.didx = didx;
		this.mid = mid;
		this.mname = mname;
		this.dname = dname;
		this.dkind = dkind;
		this.ddate = ddate;
		this.fullName=fullName;
	}
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public int getDidx() {
		return didx;
	}
	public void setDidx(int didx) {
		this.didx = didx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getDkind() {
		return dkind;
	}
	public void setDkind(String dkind) {
		this.dkind = dkind;
	}
	public java.sql.Date getDdate() {
		return ddate;
	}
	public void setDdate(java.sql.Date ddate) {
		this.ddate = ddate;
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	
	
}
