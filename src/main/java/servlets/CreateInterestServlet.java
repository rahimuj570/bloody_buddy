package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.InterestDao;
import entities.Donor;
import entities.Interest;
import helper.ConnectionProvider;

/**
 * Servlet implementation class CreateInterestServlet
 */
public class CreateInterestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateInterestServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String request_id = request.getParameter("req");
		String author_id = request.getParameter("auth");
		HttpSession sc = request.getSession();
		Donor current_user = (Donor) sc.getAttribute("current_user");
		Interest interset = new Interest();
		interset.setAuthor_id(Integer.parseInt(author_id));
		interset.setRequest_id(Integer.parseInt(request_id));
		interset.setDonor_id(current_user.getDonor_id());

		int f = new InterestDao(ConnectionProvider.main()).createInterest(interset);
		sc.setAttribute("interest_OK", "Interest Added");
		response.sendRedirect(request.getHeader("referer"));
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
