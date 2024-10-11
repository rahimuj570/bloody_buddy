package dao;

import java.security.Timestamp;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import entities.ChatRoom;

public class ChatRoomDao {
	Connection con;

	public ChatRoomDao(Connection con) {
		// TODO Auto-generated constructor stub
		this.con = con;
	}

	public boolean isRoomExist(String persions) {
		persions.strip();
		StringBuilder sb = new StringBuilder();
		sb.append(persions);
		boolean f = false;
		int count = 0;
		String query = "select count(*) as count from chat_room where persons =? or persons=?";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, persions);
			pst.setString(2, sb.reverse().toString());
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				count = res.getInt(1);
			}
			if (count != 0)
				f = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return f;
	}

	public int getRoomIdByPersons(String persions) {
		persions.strip();
		StringBuilder sb = new StringBuilder();
		sb.append(persions);
		int id = 0;
		String query = "select room_id as count from chat_room where persons =? or persons=?";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, persions);
			pst.setString(2, sb.reverse().toString());
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				id = res.getInt(1);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return id;
	}

	public int createRoom(String persons) {
		int f = 0;
		if (isRoomExist(persons)) {
			return f = getRoomIdByPersons(persons);
		} else {
			String query = "insert into chat_room (persons) value(?)";
			try {
				PreparedStatement pst = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
				pst.setString(1, persons);
				f = pst.executeUpdate();
				if (f == 1) {
					ResultSet res = pst.getGeneratedKeys();
					f = res.next() ? res.getInt(1) : 0;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return f;
	}

	public ArrayList<ChatRoom> getAllChatRoomByPersonId(int id, int pNum) {
		ArrayList<ChatRoom> crList = new ArrayList<ChatRoom>();
		String query = "select * from chat_room where persons like '" + id + ",%' or persons like '%," + id
				+ "' order by last_update desc limit 10 offset " + 10 * pNum;
		try {
			PreparedStatement pst = con.prepareStatement(query);
//			pst.setInt(1, id);
//			pst.setInt(2, id);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				ChatRoom cr = new ChatRoom();
				cr.setRoom_id(res.getInt(1));
				cr.setPersons(res.getString(2));
				cr.setIs_seen(res.getInt(3));
				cr.setLast_update(res.getTimestamp(4));
				crList.add(cr);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return crList;
	}

	public ChatRoom getChatRoomByRoomId(int id) {
		ChatRoom cr = new ChatRoom();
		String query = "select * from chat_room where room_id=" + id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				cr.setRoom_id(res.getInt(1));
				cr.setPersons(res.getString(2));
				cr.setIs_seen(res.getInt(3));
				cr.setLast_update(res.getTimestamp(4));
				cr.setSeen_by(res.getString(5));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cr;
	}

	public void changeLastUpdate(int room_id, java.sql.Timestamp last_chat_date) {
		String query = "update chat_room set last_update=? where room_id=" + room_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setTimestamp(1, last_chat_date);
			pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean isISennChat(int room_id, int uid) {
		String query = "select count(*) from chat_room where (seen_by like ('" + uid + ",%') or seen_by like ('%," + uid
				+ "')or seen_by like ('%," + uid + ",')) and room_id=" + room_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			int count = 0;
			if (res.next())
				count = res.getInt(1);
			if (count == 1)
				return true;
			else
				return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public void receiverSeen(int room_id, int uid) {
		if (!isISennChat(room_id, uid)) {
			ChatRoom cr = getChatRoomByRoomId(room_id);
			if (cr.getSeen_by().isEmpty())
				cr.setSeen_by("");
			cr.setSeen_by(cr.getSeen_by() + uid + ",");
			String query = "update chat_room set seen_by='" + cr.getSeen_by() + "' where room_id=" + room_id;
			try {
				PreparedStatement pst = con.prepareStatement(query);
				pst.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public int getUnseenRoom(int cuid) {
		int count = 0;
		String query = "select count(*) from chat_room where (seen_by not like ('" + cuid
				+ ",%') and seen_by not like ('%," + cuid + "') and seen_by not like ('%," + cuid
				+ ",')) and (persons like ('%," + cuid + "') or persons like ('" + cuid + ",%'))";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				count = res.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}

	public void makePersonSeen(int room_id, int person_id) {
		String query = "update chat_room set seen_by='" + person_id + ",' where room_id=" + room_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
