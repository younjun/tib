package tib.project.model;

import java.io.Serializable;

public class ProjectDTO implements Serializable{

	private int pidx;
	private String pname;
	private String pcode;
	private int plimit;
	private int plock;
	private String phost;
	private int pcount;
	public ProjectDTO() {
		
		// TODO Auto-generated constructor stub
	}
	public ProjectDTO(int pidx, String pname, String pcode, int plimit, int plock,String phost,int pcount) {
		super();
		this.pidx = pidx;
		this.pname = pname;
		this.pcode = pcode;
		this.plimit = plimit;
		this.plock = plock;
		this.phost=phost;
		this.pcount=pcount;
	}
	public int getPidx() {
		return pidx;
	}
	public void setPidx(int pidx) {
		this.pidx = pidx;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public int getPlimit() {
		return plimit;
	}
	public void setPlimit(int plimit) {
		this.plimit = plimit;
	}
	public int getPlock() {
		return plock;
	}
	public void setPlock(int plock) {
		this.plock = plock;
	}
	public String getPhost() {
		return phost;
	}
	public void setPhost(String phost) {
		this.phost = phost;
	}
	public int getPcount() {
		return pcount;
	}
	public void setPcount(int pcount) {
		this.pcount = pcount;
	}
	
	
}
