package entities;

import java.util.Date;

public class DonorRequest {
	int request_id;
	String patient_name;
	String why_need;
	String blood_group;
	Date when_need;
	int blood_unit;
	String mobile;
	String location;
	int created_by;

	public int getRequest_id() {
		return request_id;
	}

	public void setRequest_id(int request_id) {
		this.request_id = request_id;
	}

	public int getCreated_by() {
		return created_by;
	}

	public void setCreated_by(int created_by) {
		this.created_by = created_by;
	}

	public String getPatient_name() {
		return patient_name;
	}

	public void setPatient_name(String patient_name) {
		this.patient_name = patient_name;
	}

	public String getWhy_need() {
		return why_need;
	}

	public void setWhy_need(String why_need) {
		this.why_need = why_need;
	}

	public String getBlood_group() {
		return blood_group;
	}

	public void setBlood_group(String blood_group) {
		this.blood_group = blood_group;
	}

	public Date getWhen_need() {
		return when_need;
	}

	public void setWhen_need(Date when_need) {
		this.when_need = when_need;
	}

	public int getBlood_unit() {
		return blood_unit;
	}

	public void setBlood_unit(int blood_unit) {
		this.blood_unit = blood_unit;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	@Override
	public String toString() {
		return "DonorRequest [patient_name=" + patient_name + ", why_need=" + why_need + ", blood_group=" + blood_group
				+ ", when_need=" + when_need + ", blood_unit=" + blood_unit + ", mobile=" + mobile + ", location="
				+ location + "]";
	}

}
