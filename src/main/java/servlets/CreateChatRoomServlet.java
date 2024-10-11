package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.ChatRoomDao;
import entities.Donor;
import helper.ConnectionProvider;

/**
 * Servlet implementation class CreateChatRoomServlet
 */
public class CreateChatRoomServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateChatRoomServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String persons = request.getParameter("receiver");
		persons += ",";
		HttpSession sc = request.getSession();
		Donor cu = (Donor) sc.getAttribute("current_user");
		persons += cu.getDonor_id();
		ChatRoomDao crDao = new ChatRoomDao(ConnectionProvider.main());
		int f = crDao.createRoom(persons);
		response.sendRedirect(request.getContextPath() + "/chat.jsp?room=" + f);
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
