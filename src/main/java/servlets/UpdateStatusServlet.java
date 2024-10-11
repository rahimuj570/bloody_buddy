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
 * Servlet implementation class UpdateStatusServlet
 */
public class UpdateStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateStatusServlet() {
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
		Donor cu = (Donor) sc.getAttribute("current_user");
		int f = new DonorDao(ConnectionProvider.main()).updateStatus(cu.getDonor_id(),
				Integer.parseInt(request.getParameter("available")));
		if (f == 1) {
			if (cu.getIsAvailabe() == 1)
				cu.setIsAvailabe(0);
			else
				cu.setIsAvailabe(1);
			sc.setAttribute("current_user", cu);
		}
		sc.setAttribute("change_status_OK", "Status Changed!");
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
