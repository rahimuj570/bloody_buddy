package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.DonorDao;
import entities.Donor;
import helper.ConnectionProvider;

/**
 * Servlet implementation class RegisterServlet
 */
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession sc = request.getSession();
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String mobile = request.getParameter("mobile");
		String group = request.getParameter("group");
		String division = request.getParameter("division");
		String district = request.getParameter("district");
		String sub_district = request.getParameter("sub_district");
		password.strip();
		if (password.length() < 6) {
			sc.setAttribute("registration_BAD", "Password length must be at least 6 characters!");
			response.sendRedirect(request.getHeader("referer"));
		} else {
			Donor donor = new Donor();
			donor.setBloodgroup(group);
			donor.setDonor_email(email);
			donor.setDonor_mobile(mobile);
			donor.setDonor_name(name);
			donor.setDonor_password(password);
			donor.setIsAvailabe(1);
			donor.setDistrict(district);
			donor.setDivision(division);
			donor.setSub_district(sub_district);
			System.out.println(donor);
			int f = new DonorDao(new ConnectionProvider().main()).createDonor(donor);
//			System.out.println(f);
			if (f == 1062) {
				sc.setAttribute("registration_BAD", "Email Already Registered!");
				response.sendRedirect(request.getHeader("referer"));
			} else if (f == 1) {
				sc.setAttribute("registration_OK", "Registration Completed!");
				response.sendRedirect(request.getContextPath() + "/login.jsp");
			} else {
				sc.setAttribute("registration_BAD", "Something Went Wrong!");
				response.sendRedirect(request.getHeader("referer"));
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
