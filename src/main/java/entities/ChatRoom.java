package entities;

import java.util.Date;

public class ChatRoom {
	int room_id;
	String persons;
	int is_seen;
	Date last_update;

	public Date getLast_update() {
		return last_update;
	}

	public void setLast_update(Date last_update) {
		this.last_update = last_update;
	}

	public int getRoom_id() {
		return room_id;
	}

	public void setRoom_id(int room_id) {
		this.room_id = room_id;
	}

	public String getPersons() {
		return persons;
	}

	public void setPersons(String persons) {
		this.persons = persons;
	}

	public int getIs_seen() {
		return is_seen;
	}

	public void setIs_seen(int is_seen) {
		this.is_seen = is_seen;
	}

	@Override
	public String toString() {
		return "ChatRoom [room_id=" + room_id + ", persons=" + persons + ", is_seen=" + is_seen + ", last_update="
				+ last_update + "]";
	}

}
