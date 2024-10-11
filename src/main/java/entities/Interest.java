package entities;

import java.util.Date;

public class Interest {
	int interest_id;
	int request_id;
	int author_id;
	int donor_id;
	Date created_date;
	int is_seen;

	public int getInterest_id() {
		return interest_id;
	}

	public void setInterest_id(int interest_id) {
		this.interest_id = interest_id;
	}

	public int getRequest_id() {
		return request_id;
	}

	public void setRequest_id(int request_id) {
		this.request_id = request_id;
	}

	public int getAuthor_id() {
		return author_id;
	}

	public void setAuthor_id(int author_id) {
		this.author_id = author_id;
	}

	public int getDonor_id() {
		return donor_id;
	}

	public void setDonor_id(int donor_id) {
		this.donor_id = donor_id;
	}

	public Date getCreated_date() {
		return created_date;
	}

	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}

	public int getIs_seen() {
		return is_seen;
	}

	public void setIs_seen(int is_seen) {
		this.is_seen = is_seen;
	}

}
