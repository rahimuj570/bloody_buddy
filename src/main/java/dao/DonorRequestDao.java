package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import entities.Donor;
import entities.DonorRequest;

public class DonorRequestDao {
	Connection con;

	public DonorRequestDao(Connection con) {
		this.con = con;
	}

	public int createRequest(DonorRequest dReq) {
		int f = 0;
		String query = "insert into donor_request (patient_name,when_need,why_need,blood_group,blood_unit,mobile,where_need,created_by) value (?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, dReq.getPatient_name());
			pst.setTimestamp(2, new Timestamp((dReq.getWhen_need().getTime())));
			pst.setString(3, dReq.getWhy_need());
			pst.setString(4, dReq.getBlood_group());
			pst.setInt(5, dReq.getBlood_unit());
			pst.setString(6, dReq.getMobile());
			pst.setString(7, dReq.getLocation());
			pst.setInt(8, dReq.getCreated_by());
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		return f;
	}

	public ArrayList<DonorRequest> getRequestByDonorId(int id, int page) {
		String query = "select * from donor_request where created_by = " + id + " order by when_need asc limit 5 offset " + 5 * page;
		ArrayList<DonorRequest> allRequest = new ArrayList<DonorRequest>();
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				DonorRequest tmp = new DonorRequest();
				tmp.setRequest_id(res.getInt(1));
				tmp.setPatient_name(res.getString(2));
				tmp.setWhen_need(res.getTimestamp(3));
				tmp.setWhy_need(res.getString(4));
				tmp.setBlood_group(res.getString(5));
				tmp.setBlood_unit(res.getInt(6));
				tmp.setMobile(res.getString(7));
				tmp.setLocation(res.getString(8));
				tmp.setCreated_by(res.getInt(9));
				allRequest.add(tmp);
			}
			return allRequest;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}

	public ArrayList<DonorRequest> getRequestForHome(int page, int current_user_id) {
		String query = "select * from donor_request where request_id not in(select request_id from interest where donor_id=?) order by when_need asc limit 5 offset "
				+ 5 * page;
		ArrayList<DonorRequest> allRequest = new ArrayList<DonorRequest>();
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setInt(1, current_user_id);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				DonorRequest tmp = new DonorRequest();
				tmp.setRequest_id(res.getInt(1));
				tmp.setPatient_name(res.getString(2));
				tmp.setWhen_need(res.getTimestamp(3));
				tmp.setWhy_need(res.getString(4));
				tmp.setBlood_group(res.getString(5));
				tmp.setBlood_unit(res.getInt(6));
				tmp.setMobile(res.getString(7));
				tmp.setLocation(res.getString(8));
				tmp.setCreated_by(res.getInt(9));
				allRequest.add(tmp);
			}
			return allRequest;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}

	public int deleteRequest(int request_id) {
		int f = 0;
		String query = "delete from donor_request where request_id=" + request_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		return f;
	}

	public DonorRequest getRequestByRequestId(int id) {
		String query = "select * from donor_request where request_id=" + id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			DonorRequest tmp = new DonorRequest();
			if (res.next()) {
				tmp.setRequest_id(res.getInt(1));
				tmp.setPatient_name(res.getString(2));
				tmp.setWhen_need(res.getTimestamp(3));
				tmp.setWhy_need(res.getString(4));
				tmp.setBlood_group(res.getString(5));
				tmp.setBlood_unit(res.getInt(6));
				tmp.setMobile(res.getString(7));
				tmp.setLocation(res.getString(8));
				tmp.setCreated_by(res.getInt(9));
			}
			return tmp;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}

	public int updateRequest(DonorRequest dReq) {
		int f = 0;
		String query = "update donor_request set patient_name=?,when_need=?,why_need=?,blood_group=?,blood_unit=?,mobile=?,where_need=?,created_by=? where request_id="
				+ dReq.getRequest_id();
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, dReq.getPatient_name());
			pst.setTimestamp(2, new Timestamp((dReq.getWhen_need().getTime())));
			pst.setString(3, dReq.getWhy_need());
			pst.setString(4, dReq.getBlood_group());
			pst.setInt(5, dReq.getBlood_unit());
			pst.setString(6, dReq.getMobile());
			pst.setString(7, dReq.getLocation());
			pst.setInt(8, dReq.getCreated_by());
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		return f;
	}

}
