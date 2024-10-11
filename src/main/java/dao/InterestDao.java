package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entities.DonorRequest;
import entities.Interest;

public class InterestDao {
	Connection con;

	public InterestDao(Connection con) {
		// TODO Auto-generated constructor stub
		this.con = con;
	}

	public int createInterest(Interest interest) {
		int f = 0;
		String query = "insert into interest (request_id,author_id,donor_id) value (?,?,?)";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setInt(1, interest.getRequest_id());
			pst.setInt(2, interest.getAuthor_id());
			pst.setInt(3, interest.getDonor_id());
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		return f;
	}

	public int deleteInterest(int req_id, int uid) {
		int f = 0;
		String query = "delete from interest where request_id=" + req_id + " and donor_id=" + uid;
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

	public ArrayList<DonorRequest> getInterestByDonorID(int page, int current_user_id) {
		String query = "select * from donor_request where request_id in(select request_id from interest where donor_id=?) order by when_need asc limit 5 offset "
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

	public ArrayList<DonorRequest> getInterestForNotification(int page, int current_user_id) {
		String query = "select * from donor_request where created_by=" + current_user_id
				+ " and created_by in (select author_id from interest) and request_id in(select request_id from interest) order by when_need asc limit 5 offset "
				+ 5 * page;
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

	public ArrayList<DonorRequest> getUnseenInterestForNotification(int page, int current_user_id) {
		String query = "select * from donor_request where created_by=" + current_user_id
				+ " and created_by in (select author_id from interest where is_seen=0) and request_id in(select request_id from interest where is_seen=0) order by when_need asc";
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

	public int countUnseenInterest(int current_user_id) {
		int f = 0;
		String query = "select count(*) as length  from donor_request where created_by=" + current_user_id
				+ " and created_by in (select author_id from interest where is_seen=0) and request_id in(select request_id from interest where is_seen=0)";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next())
				f = res.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return f;
	}
	
	public void seenAllInterest(int user_id) {
		String query = "update interest set is_seen=1 where author_id="+user_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
