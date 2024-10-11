package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;

import entities.Chats;
import helper.ConnectionProvider;

public class ChatsDao {
	Connection con;

	public ChatsDao(Connection con) {
		// TODO Auto-generated constructor stub
		this.con = con;
	}

	public Chats getLastChatByRoomId(int id) {
		Chats c = new Chats();
		String query = "select * from chats where chat_room=" + id + " order by sent_date desc limit 1";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				c.setChat_id(res.getInt(1));
				c.setChat_room(res.getInt(2));
				c.setSender(res.getInt(3));
				c.setChat_text(res.getString(4));
				c.setSent_date(res.getTimestamp(5));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return c;
	}

	public ArrayList<Chats> getAllChatsByRoomId(int id, int pNum) {
		ArrayList<Chats> cList = new ArrayList<Chats>();
		String query = "select * from chats where chat_room=" + id + " order by sent_date desc limit 20 offset "
				+ 20 * pNum;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Chats c = new Chats();
				c.setChat_id(res.getInt(1));
				c.setChat_room(res.getInt(2));
				c.setSender(res.getInt(3));
				c.setChat_text(res.getString(4));
				c.setSent_date(res.getTimestamp(5));
				cList.add(c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ArrayList<Chats> cListReverse = new ArrayList<Chats>();
		for (int i = cList.size() - 1; i >= 0; i--) {
			cListReverse.add(cList.get(i));
		}
		return cListReverse;
	}

	public int sentMessage(String message, int room_id, int sender) {
		int f = 0;
		String query = "insert into chats (chat_room, sender, chat_text) values (?,?,?)";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setInt(1, room_id);
			pst.setInt(2, sender);
			pst.setString(3, message);
			f = pst.executeUpdate();
			new ChatRoomDao(con).changeLastUpdate(room_id, new Timestamp(System.currentTimeMillis()));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return f;
	}
}
