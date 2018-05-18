package cn.huazx.ebp.modules.test.entity;

import org.hibernate.validator.constraints.Length;

import cn.huazx.ebp.common.persistence.DataEntity;

/**
 * 111Entity
 * @author 111
 * @version 2016-11-30
 */
public class TestProject extends DataEntity<TestProject> {
	
	private static final long serialVersionUID = 1L;
	private String projecctname;		// projecctname
	private String projectaddress;		// projectaddress
	private String tradecode;		// tradecode
	private String tradename;		// tradename
	private String approvaldate;		// approvaldate
	
	public TestProject() {
		super();
	}

	public TestProject(String id){
		super(id);
	}

	@Length(min=0, max=300, message="projecctname长度必须介于 0 和 300 之间")
	public String getProjecctname() {
		return projecctname;
	}

	public void setProjecctname(String projecctname) {
		this.projecctname = projecctname;
	}
	
	@Length(min=0, max=500, message="projectaddress长度必须介于 0 和 500 之间")
	public String getProjectaddress() {
		return projectaddress;
	}

	public void setProjectaddress(String projectaddress) {
		this.projectaddress = projectaddress;
	}
	
	@Length(min=0, max=100, message="tradecode长度必须介于 0 和 100 之间")
	public String getTradecode() {
		return tradecode;
	}

	public void setTradecode(String tradecode) {
		this.tradecode = tradecode;
	}
	
	@Length(min=0, max=300, message="tradename长度必须介于 0 和 300 之间")
	public String getTradename() {
		return tradename;
	}

	public void setTradename(String tradename) {
		this.tradename = tradename;
	}
	
	@Length(min=0, max=100, message="approvaldate长度必须介于 0 和 100 之间")
	public String getApprovaldate() {
		return approvaldate;
	}

	public void setApprovaldate(String approvaldate) {
		this.approvaldate = approvaldate;
	}
	
}