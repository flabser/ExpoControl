package kz.pchelka.reminder;

import kz.pchelka.env.Environment;
import kz.pchelka.server.Server;

import javax.mail.*;
import javax.mail.internet.*;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Properties;

public class Memo {
	private MimeMessage msg;
	private String smtpServer = Environment.SMTPHost;
	private String smtpPort = Environment.smtpPort;
    private String smtpUser = Environment.smtpUser;
    private String smtpPassword = Environment.smtpPassword;
	private boolean smtpAuth = Environment.smtpAuth;
	private boolean isValid;
	private boolean hasRecipients;

	public Memo(String sender, List<String> recipients, String subj, String body){
		if (Environment.mailEnable){
			Properties props = new Properties();
			props.put("mail.smtp.host",smtpServer);
            Session ses;
            if (smtpAuth) {
                props.put("mail.smtp.auth", smtpAuth);
                props.put("mail.smtp.port", smtpPort);
                Authenticator auth = new SMTPAuthenticator();
                ses = Session.getInstance(props, auth);
            } else {
                ses = Session.getInstance(props, null);
            }

			msg = new MimeMessage(ses);
			hasRecipients = false;

			try {
				msg.setFrom(new InternetAddress(sender));

				for (String recipient : recipients){
					try{
						msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
						hasRecipients = true;
					}catch(AddressException ae){
						Environment.logger.errorLogEntry("Incorrect e-mail \"" + recipient + "\"");
						continue;
					}
				}			
				if (hasRecipients){
					msg.setSubject(subj, "utf-8");
					Multipart mp = new MimeMultipart();
					BodyPart htmlPart = new MimeBodyPart();
					htmlPart.setContent(body,"text/html; charset=utf-8");
					mp.addBodyPart(htmlPart);
					msg.setContent(mp);		
					isValid = true;
				}else{
					Environment.logger.errorLogEntry("Unable to send the message. List of recipients is empty or consist is incorrect data");
				}
			} catch (MessagingException e) {
                Environment.logger.errorLogEntry(e);
			}	
		}
	}

	public Memo(String sender, String personal, List<String> recipients, String subj, String body){
		if (Environment.mailEnable){
			Properties props = new Properties();
			props.put("mail.smtp.host",smtpServer);
            props.put("mail.smtp.auth", true);
            props.put("mail.smtp.port", 25);
            Authenticator auth = new SMTPAuthenticator();
			Session ses = Session.getInstance(props, auth);
			msg = new MimeMessage(ses);
			hasRecipients = false;

			try {
				msg.setFrom(new InternetAddress(sender, personal));

				for (String recipient : recipients){
					try{
						msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
						hasRecipients = true;
					}catch(AddressException ae){
						Environment.logger.errorLogEntry("Incorrect e-mail \"" + recipient + "\"");
						continue;
					}
				}			
				if (hasRecipients){				
					msg.setSubject(subj, "utf-8");
					Multipart mp = new MimeMultipart();
					BodyPart htmlPart = new MimeBodyPart();
					htmlPart.setContent(body,"text/html; charset=utf-8");
					mp.addBodyPart(htmlPart);
					msg.setContent(mp);		
					isValid = true;
				}else{
					//Environment.logger.errorLogEntry("Unable to send the message. List of recipients is empty or consist is incorrect data");
				}
			} catch (MessagingException e) {
                Environment.logger.errorLogEntry(e);
			} catch (UnsupportedEncodingException e) {
                Environment.logger.errorLogEntry(e);
			}	
		}
	}


	public boolean send(){
		try {
			if (Environment.mailEnable && isValid){
				Transport.send(msg);
				return true;
			}
		}catch(SendFailedException se){
			if (se.getMessage().contains("Relay rejected for policy reasons")){
				Server.logger.warningLogEntry("Relay rejected for policy reasons by SMTP server. Message has not sent");
			}else{
				Environment.logger.errorLogEntry("Unable to send a message, probably SMTP host did not set");		
				Environment.logger.errorLogEntry(se);
			}
		} catch (MessagingException e) {
			Environment.logger.errorLogEntry(e);			
		}
		return false;
	}


    class SMTPAuthenticator extends javax.mail.Authenticator
    {
        public PasswordAuthentication getPasswordAuthentication()
        {
            return new PasswordAuthentication(smtpUser, smtpPassword);
        }
    }

}