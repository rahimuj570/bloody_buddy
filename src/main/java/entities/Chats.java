package entities;

import java.util.Date;

public class Chats {
	int chat_id;
	int chat_room;
	int sender;
	String chat_text;
	Date sent_date;

	public int getChat_id() {
		return chat_id;
	}

	public void setChat_id(int chat_id) {
		this.chat_id = chat_id;
	}

	public int getChat_room() {
		return chat_room;
	}

	public void setChat_room(int chat_room) {
		this.chat_room = chat_room;
	}

	public int getSender() {
		return sender;
	}

	public void setSender(int sender) {
		this.sender = sender;
	}

	public String getChat_text() {
		return chat_text;
	}

	public void setChat_text(String chat_text) {
		this.chat_text = chat_text;
	}

	public Date getSent_date() {
		return sent_date;
	}

	public void setSent_date(Date sent_date) {
		this.sent_date = sent_date;
	}

}
