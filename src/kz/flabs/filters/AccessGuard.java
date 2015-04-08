package kz.flabs.filters;

import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.commons.codec.binary.Base64;

import java.io.*;
import java.nio.charset.Charset;

import kz.flabs.appenv.AppEnv;
import kz.flabs.dataengine.DatabaseFactory;
import kz.flabs.dataengine.ISystemDatabase;
import kz.flabs.dataengine.IUsersActivity;
import kz.flabs.dataengine.h2.LoginModeType;
import kz.flabs.dataengine.h2.UserApplicationProfile;
import kz.flabs.servlets.BrowserType;
import kz.flabs.servlets.Cookies;
import kz.flabs.servlets.ProviderOutput;
import kz.flabs.servlets.ServletUtil;
import kz.flabs.servlets.Login.CallingPageCookie;
import kz.flabs.users.AuthFailedException;
import kz.flabs.users.AuthFailedExceptionType;
import kz.flabs.users.User;
import kz.flabs.users.UserException;
import kz.flabs.users.UserSession;
import kz.flabs.util.ResponseType;
import kz.flabs.util.Util;
import kz.flabs.util.XMLResponse;
import kz.flabs.webrule.constants.RunMode;
import kz.flabs.webrule.eds.EDSSetting;
import kz.flabs.workspace.LoggedUser;
import kz.flabs.workspace.WorkSpaceSession;
import kz.pchelka.env.AuthTypes;
import kz.pchelka.env.Environment;

public class AccessGuard implements Filter {
	private ServletContext context;
	private AppEnv env;

	public void init(FilterConfig config) throws ServletException {

	}

	public void doFilter(ServletRequest request, ServletResponse resp,
			FilterChain chain) {
		try {
			HttpServletRequest http = (HttpServletRequest) request;
			HttpServletResponse httpResponse = (HttpServletResponse) resp;
			context = http.getServletContext();
			env = (AppEnv) context.getAttribute("portalenv");

			String cApp = env.appType;
			Cookies appCookies = new Cookies(http);
			String token = appCookies.wAuthHash;

			if (env.authType == AuthTypes.BASIC) {
				ISystemDatabase systemDatabase = DatabaseFactory.getSysDatabase();
				String[] userAndPwd = null;
				String authorization = http.getHeader("Authorization");
				if (authorization != null && authorization.startsWith("Basic")) {
					String encodedUserAndPwd = authorization.substring("Basic".length()).trim();
					String decodedUserAndPwd = new String(Base64.decodeBase64(encodedUserAndPwd),
							Charset.forName("UTF-8"));
					userAndPwd = decodedUserAndPwd.split(":",2);
				} else {
					request.getRequestDispatcher(
							"/Error?type=access_guard_error").forward(
									request, resp);
				}
				User user = new User(env);
				user = systemDatabase.checkUserHash(userAndPwd[0], userAndPwd[1], appCookies.authHash, user);
				if (user.authorized){
					String userID = user.getUserID();						

					boolean saveToken = true;

					HttpSession jses = http.getSession(true);					
					UserSession userSession = new UserSession(user, http, httpResponse, saveToken,jses);			

					AppEnv.logger.normalLogEntry(userID + " has connected");
					IUsersActivity ua = env.getDataBase().getUserActivity();
					ua.postLogin(userSession.browserType, ServletUtil.getClientIpAddr(http), userID);

					// WTF?
					/*EDSSetting es = env.ruleProvider.global.edsSettings;
                    if (es.isOn == RunMode.ON) {
                        this.addEDSCookies(es, httpResponse);
                    }*/

					UserApplicationProfile userAppProfile = user.enabledApps.get(env.appType); 
					if (userAppProfile != null){
						jses.setAttribute("usersession",userSession);
					} else {
						request.getRequestDispatcher(
								"/Error?type=access_guard_error").forward(
										request, resp);
					}
				} else {
					request.getRequestDispatcher(
							"/Error?type=access_guard_error").forward(
									request, resp);
				}
				chain.doFilter(request, resp);
			} else {
				if (!token.equalsIgnoreCase("")) {
					LoggedUser logUser = WorkSpaceSession.getLoggeedUser(token);

					if (logUser != null) {
						User user = logUser.getUser();

						if (user.enabledApps.containsKey(cApp)
								|| cApp.trim().equals("Workspace")
								|| cApp.trim().equals("administrator")) {
							chain.doFilter(request, resp);
						} else {

							request.getRequestDispatcher(
									"/Error?type=access_guard_error").forward(
											request, resp);
							AppEnv.logger.errorLogEntry("For user \"" + user.getUserID() + "\" application '" + cApp + "' access denied");

						}
					}else{
						chain.doFilter(request, resp);
					}
				}else{
					chain.doFilter(request, resp);
				}
			}
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} catch (UserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void destroy() {

	}

}
