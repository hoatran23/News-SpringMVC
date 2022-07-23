package com.hoatt.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@MappedSuperclass
@EntityListeners({AuditingEntityListener.class})
public abstract class BaseEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(name = "createdby")
	@CreatedBy
	private String createdBy;

	@Column(name = "createddata")
	@CreatedDate
	private Date createdDate;
	
	@Column(name = "modifiedby")
	@LastModifiedBy
	private String modifiedBy;
	
	@Column(name = "modifieddate")
	@LastModifiedDate
	private Date modifiedDate;
	
	public Long getId() {
		return id;
	}
	
	public String getCreatedBy() {
		return createdBy;
	}
	
	public Date getCreatedDate() {
		return createdDate;
	}
	
	public String getModifiedBy() {
		return modifiedBy;
	}
	
	public Date getModifiedDate() {
		return modifiedDate;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public void setModifiedBy(String modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
}
