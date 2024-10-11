package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entities.Donor;

public class DonorDao {
	Connection con;

	public DonorDao(Connection con) {
		this.con = con;
	}

	public int createDonor(Donor donor) {
		String query = "insert into donor (donor_name, donor_email, donor_mobile, donor_password,donor_blood_group, donor_isAvailable,division,district,sub_district) value (?,?,?,?,?,?,?,?,?)";
		int f = 0;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, donor.getDonor_name());
			pst.setString(2, donor.getDonor_email());
			pst.setString(3, donor.getDonor_mobile());
			pst.setString(4, donor.getDonor_password());
			pst.setString(5, donor.getBloodgroup());
			pst.setInt(6, donor.getIsAvailabe());
			pst.setString(7, donor.getDivision());
			pst.setString(8, donor.getDistrict());
			pst.setString(9, donor.getSub_district());
			f = pst.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			f = e.getErrorCode();
			return f;
		}

		return f;
	}

	public Donor loginDonner(String email, String password) {
		Donor donor = new Donor();
		String query = "select * from donor where donor_email='" + email + "' and donor_password='" + password + "'";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				donor.setBloodgroup(res.getString("donor_blood_group"));
				donor.setDonor_email(res.getString("donor_email"));
				donor.setDonor_id(res.getInt("donor_id"));
				donor.setDonor_mobile(res.getString("donor_mobile"));
				donor.setDonor_name(res.getString("donor_name"));
				donor.setDonor_password(res.getString("donor_password"));
				donor.setIsAvailabe(res.getInt("donor_isAvailable"));
				donor.setDivision(res.getString(8));
				donor.setDistrict(res.getString(9));
				donor.setSub_district(res.getString(10));
			} else {
				return null;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		return donor;
	}

	public Donor getDonorById(int id) {
		Donor d = new Donor();
		String query = "select * from donor where donor_id=" + id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				d.setDonor_id(res.getInt(1));
				d.setDonor_name(res.getString(2));
				d.setDonor_email(res.getString(3));
				d.setDonor_mobile(res.getString(4));
				d.setDonor_password(res.getString(5));
				d.setBloodgroup(res.getString(6));
				d.setIsAvailabe(res.getInt(7));
				d.setDivision(res.getString(8));
				d.setDistrict(res.getString(9));
				d.setSub_district(res.getString(10));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return d;
	}

	public int updateDonor(Donor donor) {
		int f = 0;
		String query = "update donor set donor_name=?, donor_email=?, donor_mobile=?, donor_password=?,donor_blood_group=?, donor_isAvailable=?,division=?,district=?,sub_district=? where donor_id="
				+ donor.getDonor_id();
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, donor.getDonor_name());
			pst.setString(2, donor.getDonor_email());
			pst.setString(3, donor.getDonor_mobile());
			pst.setString(4, donor.getDonor_password());
			pst.setString(5, donor.getBloodgroup());
			pst.setInt(6, donor.getIsAvailabe());
			pst.setString(7, donor.getDivision());
			pst.setString(8, donor.getDistrict());
			pst.setString(9, donor.getSub_district());
			f = pst.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			f = e.getErrorCode();
			return f;
		}
		return f;
	}

	public int updateStatus(int current_user_id, int status) {
		int f = 0;
		String query = "update donor set donor_isAvailable=? where donor_id=" + current_user_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setInt(1, status);
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return f;
	}

	public ArrayList<Donor> findAvailableDonors(int current_user_id, String division, String district,
			String sub_district, int pNum) {
		ArrayList<Donor> dList = new ArrayList<Donor>();
		String query = "select * from donor where donor_id!=" + current_user_id + " and donor_isAvailable=1";
		if (!district.isEmpty() && !division.isEmpty() && !sub_district.isEmpty()) {
			query = "select * from donor where donor_id!=" + current_user_id
					+ " and donor_isAvailable=1 and division='"+division+"' and district='"+district+"' and sub_district='"+sub_district+"'";
		}
		query+=" limit 20 offset "+20*pNum;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Donor d = new Donor();
				d.setDonor_id(res.getInt(1));
				d.setDonor_name(res.getString(2));
				d.setDonor_email(res.getString(3));
				d.setDonor_mobile(res.getString(4));
				d.setDonor_password(res.getString(5));
				d.setBloodgroup(res.getString(6));
				d.setIsAvailabe(res.getInt(7));
				d.setDivision(res.getString(8));
				d.setDistrict(res.getString(9));
				d.setSub_district(res.getString(10));
				dList.add(d);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dList;
	}
}
