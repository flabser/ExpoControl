package kz.flabs.servlets;

import kz.flabs.dataengine.Const;
import kz.pchelka.env.Environment;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class Redirector extends HttpServlet implements Const {
	private static final long serialVersionUID = 2107838212730208929L;

	protected void  doGet(HttpServletRequest request, HttpServletResponse response){
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response){

		try {
			response.sendRedirect(Environment.getWorkspaceURL());
		} catch (IOException e) {		
			e.printStackTrace();
		}

	}	



}
