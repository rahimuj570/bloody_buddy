package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.DonorRequestDao;
import dao.InterestDao;
import entities.Donor;
import helper.ConnectionProvider;

/**
 * Servlet implementation class DeleteInterestServlet
 */
public class DeleteInterestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteInterestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String request_id = request.getParameter("req");
		InterestDao intDao = new InterestDao(ConnectionProvider.main());
		HttpSession sc = request.getSession();
		Donor current_user =(Donor) sc.getAttribute("current_user");
		int f = intDao.deleteInterest(Integer.parseInt(request_id), current_user.getDonor_id());
		sc.setAttribute("delete_int_OK", "Interest Successfully Removed!");
		response.sendRedirect(request.getHeader("referer"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
