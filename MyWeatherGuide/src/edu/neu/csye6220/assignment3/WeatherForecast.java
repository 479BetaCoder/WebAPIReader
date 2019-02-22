package edu.neu.csye6220.assignment3;

import java.io.IOException;
import java.io.StringReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/**
 * Servlet implementation class WeatherForecast
 */
@WebServlet("/WeatherForecast")
public class WeatherForecast extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public WeatherForecast() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String city = "";
		String country = "US";
		if (request.getParameter("txtCity") != null && request.getParameter("txtCity").trim() != "") {
			city = request.getParameter("txtCity").replaceAll("\\s", "");
		}
		if (request.getParameter("txtCountry") != null && request.getParameter("txtCountry").trim() != "") {
			country = request.getParameter("txtCountry").replaceAll("\\s", "");
		}
		try {
			String weatherXml = getForecast(city, country);
			Weather wResult =	readXmlForecast(weatherXml);
			request.setAttribute("wer", wResult);
			
			RequestDispatcher rd = request.getRequestDispatcher("WeatherForecast.jsp");
			rd.forward(request, response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public Weather readXmlForecast(String weatherContent) {

		Weather wObj = new Weather();

		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		try {
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.parse(new InputSource(new StringReader(weatherContent)));
			document.getDocumentElement().normalize();

			NodeList nameList = document.getElementsByTagName("name");
			wObj.setLocation(nameList.item(0).getTextContent());

			NodeList countryList = document.getElementsByTagName("country");
			wObj.setCountry(countryList.item(0).getTextContent());

			NodeList timeList = document.getElementsByTagName("time");
//			NodeList symbolList = document.getElementsByTagName("symbol");
//			NodeList wsList = document.getElementsByTagName("windSpeed");
//			NodeList tempList = document.getElementsByTagName("temperature");
//			NodeList pressureList = document.getElementsByTagName("humidity");

			for (int i = 0; i < 1; i++) {
				Node time = timeList.item(i);
				if (time.getNodeType() == Node.ELEMENT_NODE) {
					Element e = (Element) time;

					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
					Date fromDate = dateFormat.parse(e.getAttribute("from"));
					Date toDate = dateFormat.parse(e.getAttribute("to"));
					wObj.addFromTime(fromDate);
					wObj.addToTime(toDate);

					NodeList timeChildList = e.getChildNodes();
					for (int j = 0; j < timeChildList.getLength(); j++) {
						Node ch = timeChildList.item(j);
						if (ch.getNodeType() == Node.ELEMENT_NODE) {
							Element ej = (Element) ch;
							String nodeName = ej.getNodeName();

							switch (nodeName) {

							case "symbol":
								wObj.setSkyStatus(ej.getAttribute("name"));
								break;
							case "windSpeed":
								wObj.setWindSpeed(ej.getAttribute("name"));
								break;
							case "temperature":
							    wObj.setTemperature(Double.parseDouble(ej.getAttribute("value")));
								break;
							case "pressure":
								wObj.setPressure(Double.parseDouble(ej.getAttribute("value")));
								break;
							case "humidity":
								wObj.setHumidity(Double.parseDouble(ej.getAttribute("value")));
								break;

							}

						}
					}
				}
				
			}

		} catch (SAXException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		return wObj;

	}

	public String getForecast(String city, String country) throws Exception {

		CloseableHttpClient httpClient = HttpClients.createDefault();
		String uri = "http://api.openweathermap.org/data/2.5/forecast?q=" + city + "," + country
				+ "&mode=xml&APPID=7e7b1f6023f3d42eab030a4817826c8a";
		HttpGet getForecast = new HttpGet(uri);
		CloseableHttpResponse httpResponse = httpClient.execute(getForecast);
		HttpEntity httpEntity = httpResponse.getEntity();
		String xml = EntityUtils.toString(httpEntity);
		return xml;

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
