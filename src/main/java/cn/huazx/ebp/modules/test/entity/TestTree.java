package cn.huazx.ebp.modules.test.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import cn.huazx.ebp.common.persistence.TreeEntity;

/**
 * 树结构生成Entity
 * @author ThinkGem
 * @version 2016-11-30
 */
public class TestTree extends TreeEntity<TestTree> {
	
	private static final long serialVersionUID = 1L;
	private TestTree parent;		// parent_id
	private String parentIds;		// parent_ids
	private String name;		// name
	private Integer sort;		// sort
	
	public TestTree() {
		super();
	}

	public TestTree(String id){
		super(id);
	}

	@JsonBackReference
	@NotNull(message="parent_id不能为空")
	public TestTree getParent() {
		return parent;
	}

	public void setParent(TestTree parent) {
		this.parent = parent;
	}
	
	@Length(min=1, max=2000, message="parent_ids长度必须介于 1 和 2000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	@Length(min=1, max=100, message="name长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@NotNull(message="sort不能为空")
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}
}