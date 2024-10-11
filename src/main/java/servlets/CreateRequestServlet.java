package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import dao.DonorDao;
import dao.DonorRequestDao;
import entities.Donor;
import entities.DonorRequest;
import helper.ConnectionProvider;

/**
 * Servlet implementation class CreateRequestServlet
 */
public class CreateRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateRequestServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession sc = request.getSession();
		DonorRequest dReq = new DonorRequest();
		String dt = request.getParameter("date");
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
		Date date = null;
		try {
			date = (Date) formatter.parse(dt);
			Date tp = formatter.parse(dt);
			System.out.println(tp);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dReq.setBlood_group(request.getParameter("group"));
		dReq.setWhen_need(date);
		dReq.setBlood_unit(Integer.parseInt(request.getParameter("need")));
		dReq.setLocation(request.getParameter("location"));
		dReq.setMobile(request.getParameter("mobile"));
		dReq.setPatient_name(request.getParameter("patient_name"));
		dReq.setWhy_need(request.getParameter("why"));
		Donor current_user = (Donor) sc.getAttribute("current_user");
		dReq.setCreated_by(current_user.getDonor_id());
		int f = new DonorRequestDao(ConnectionProvider.main()).createRequest(dReq);
		sc.setAttribute("request_OK", "Request Successfully Created!");
		response.sendRedirect(request.getContextPath()+"/my_request.jsp");
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
