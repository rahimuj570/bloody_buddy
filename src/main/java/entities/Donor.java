package entities;

public class Donor {
	private int donor_id;
	private String donor_name;
	private String donor_email;
	private String donor_mobile;
	private String donor_password;
	private String bloodgroup;
	private String division;
	private String district;
	private String sub_district;
	private int isAvailabe;

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getSub_district() {
		return sub_district;
	}

	public void setSub_district(String sub_district) {
		this.sub_district = sub_district;
	}

	public int getDonor_id() {
		return donor_id;
	}

	public void setDonor_id(int donor_id) {
		this.donor_id = donor_id;
	}

	public String getDonor_name() {
		return donor_name;
	}

	public void setDonor_name(String donor_name) {
		this.donor_name = donor_name;
	}

	public String getDonor_email() {
		return donor_email;
	}

	public void setDonor_email(String donor_email) {
		this.donor_email = donor_email;
	}

	public String getDonor_mobile() {
		return donor_mobile;
	}

	public void setDonor_mobile(String donor_mobile) {
		this.donor_mobile = donor_mobile;
	}

	public String getDonor_password() {
		return donor_password;
	}

	public void setDonor_password(String donor_password) {
		this.donor_password = donor_password;
	}

	public String getBloodgroup() {
		return bloodgroup;
	}

	public void setBloodgroup(String bloodgroup) {
		this.bloodgroup = bloodgroup;
	}

	public int getIsAvailabe() {
		return isAvailabe;
	}

	public void setIsAvailabe(int isAvailabe) {
		this.isAvailabe = isAvailabe;
	}

	@Override
	public String toString() {
		return "Donor [donor_id=" + donor_id + ", donor_name=" + donor_name + ", donor_email=" + donor_email
				+ ", donor_mobile=" + donor_mobile + ", donor_password=" + donor_password + ", bloodgroup=" + bloodgroup
				+ ", division=" + division + ", district=" + district + ", sub_district=" + sub_district
				+ ", isAvailabe=" + isAvailabe + "]";
	}

}
