package helper;

public class GetProperBloodGroupName {
	String proper_name;

	public GetProperBloodGroupName(String s) {
		if (s.equals("a_pos"))
			proper_name = "A+";
		else if (s.equals("a_neg"))
			proper_name = "A-";
		else if (s.equals("ab_neg"))
			proper_name = "AB-";
		else if (s.equals("ab_pos"))
			proper_name = "AB+";
		else if (s.equals("o_neg"))
			proper_name = "O-";
		else
			proper_name = "O+";
	}

	public String getProper_name() {
		return proper_name;
	}

}
