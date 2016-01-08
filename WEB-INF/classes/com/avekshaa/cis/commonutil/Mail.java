package com.avekshaa.cis.commonutil;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Mail {
	static ConfigurationVo vo = null;
	static {
		try {
			vo = Configuration.configure();

		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public void mailer(String message,String recipient)
	{
	
		try {
			Properties props = new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com"); // for gmail use
															// smtp.gmail.com
			props.put("mail.smtp.auth", "true");
			props.put("mail.debug", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.port", "465");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class",
					"javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.socketFactory.fallback", "false");
			Session mailSession = Session.getInstance(props,
					new javax.mail.Authenticator() {

						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(vo.getEmail(), vo
									.getPassword());
						}
					});
			mailSession.setDebug(true); // Enable the debug mode
			Message msg1 = new MimeMessage(mailSession);
			msg1.setFrom(new InternetAddress(vo.getEmail()));
			msg1.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(recipient));
			msg1.setSentDate(new Date());
			msg1.setSubject("APPLICATION ALERT");
			msg1.setContent(message, "text/html");

		//	msg1.setText(message);
			Transport.send(msg1);

		} catch (Exception E) {
			E.printStackTrace();

		}

	}

}
