package controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Grupos;
import persistence.GenericDAO;
import persistence.GruposDAO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/grupos")
public class GruposServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public GruposServlet() {
		super();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String botao = request.getParameter("botao");
		
		GenericDAO gDao = new GenericDAO();
		GruposDAO grupoDao = new GruposDAO(gDao);
		
		List<Grupos> grupoA = new ArrayList<>();
		List<Grupos> grupoB = new ArrayList<>();
		List<Grupos> grupoC = new ArrayList<>();
		List<Grupos> grupoD = new ArrayList<>();
		
		String erro = "";
		
		try {
			if (botao.equalsIgnoreCase("gerar")) {
				grupoA = grupoDao.grupoA();
				grupoB = grupoDao.grupoB();
				grupoC = grupoDao.grupoC();
				grupoD = grupoDao.grupoD();
			}
		} catch (Exception e) {
			erro = e.getMessage();
		} finally {
			request.setAttribute("erro", erro);
			request.setAttribute("grupoA", grupoA);
			request.setAttribute("grupoB", grupoB);
			request.setAttribute("grupoC", grupoC);
			request.setAttribute("grupoD", grupoD);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("grupos.jsp");
			dispatcher.forward(request, response);
		}
		
	}
}
