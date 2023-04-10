package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Jogos;
import persistence.GenericDAO;
import persistence.JogosDAO;

@WebServlet("/jogos")
public class JogosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public JogosServlet() {
		super();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String botao = request.getParameter("botao");
		
		GenericDAO gDao = new GenericDAO();
		JogosDAO jDao = new JogosDAO(gDao);
		
		List<Jogos> jogos = new ArrayList<>();
		String erro = "";
		
		try {
			if(botao.equalsIgnoreCase("gerar")) {
				jogos = jDao.listarJogos();
			}
		} catch (Exception e) {
			erro = e.getMessage();
		} finally {
			request.setAttribute("erro",erro);
			request.setAttribute("jogos", jogos);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("jogos.jsp");
			dispatcher.forward(request, response);
		}
	}
}
