package edu.neu.csye6220.rssFeed;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
 * Servlet implementation class Subscribe
 */
@WebServlet("/Subscribe")
public class Subscribe extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Subscribe() {
		super();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession sessionFeed = request.getSession();
		sessionFeed.setAttribute("feedCnt", false);

		String url = request.getParameter("txtFeedUrl");
		String feedContent;
		int feedLimit = 0;
		String redirectPage = "Subscribe.jsp";
		try {
			if (request.getParameter("txtFeedLimit") != null && request.getParameter("txtFeedLimit").trim() != "") {
				feedLimit = Integer.parseInt(request.getParameter("txtFeedLimit"));
			}
			if (url != null && url.trim() != "") {

				sessionFeed.setMaxInactiveInterval(900);
				ArrayList<Feed> feedObjList;
				synchronized (sessionFeed) {
					feedObjList = (ArrayList<Feed>) sessionFeed.getAttribute("rss");
					if (feedObjList == null) {
						feedObjList = new ArrayList<Feed>();
						sessionFeed.setAttribute("rss", feedObjList);
					}

					feedContent = getFeed(url);
					if (feedContent != null) {
						readXmlFeed(feedContent, feedLimit, feedObjList);
						sessionFeed.setAttribute("feedCnt", true);

					} else {
						sessionFeed.setAttribute("feedCnt", false);
						response.sendRedirect("ErrorSub.jsp");
					}

				}
			}
		} catch (Exception e) {
			sessionFeed.setAttribute("feedCnt", false);
			redirectPage = "ErrorSub.jsp";
		}
		
		response.sendRedirect(redirectPage);
	}

	public void readXmlFeed(String feedContent, int feedLimit, ArrayList<Feed> fdObjList)
			throws ParserConfigurationException, SAXException, IOException

	{
		Feed fdObj = new Feed();

		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();

		Document document = builder.parse(new InputSource(new StringReader(feedContent)));
		document.getDocumentElement().normalize();

		Node channelName = document.getElementsByTagName("channel").item(0);
		Element ech = (Element) channelName;

		NodeList chTitleList = ech.getElementsByTagName("title");
		Element chTitleElem = (Element) chTitleList.item(0);

		// get the "text node" in the title (only one)
		Node chTitleNode = chTitleElem.getChildNodes().item(0);

		for (Iterator<Feed> iterator = fdObjList.iterator(); iterator.hasNext();) {
			Feed fd = iterator.next();
			if (fd.getFeedName().equalsIgnoreCase(chTitleNode.getNodeValue())) {
				iterator.remove();
			}
		}

		fdObj.setFeedName(chTitleNode.getNodeValue());

		NodeList items = document.getElementsByTagName("item");
		int limit = items.getLength() > feedLimit ? feedLimit : items.getLength();
		for (int i = 0; i < limit; i++) {
			FeedItem fditem = new FeedItem();
			Node n = items.item(i);
			if (n.getNodeType() != Node.ELEMENT_NODE)
				continue;
			Element e = (Element) n;

			NodeList titleList = e.getElementsByTagName("title");
			Element titleElem = (Element) titleList.item(0);
			NodeList linkList = e.getElementsByTagName("link");
			Element linkElem = (Element) linkList.item(0);

			// get the "text node" in the title (only one)
			Node titleNode = titleElem.getChildNodes().item(0);
			Node linkNode = linkElem.getChildNodes().item(0);

			fditem.setTitle(titleNode.getNodeValue());
			fditem.setLink(linkNode.getNodeValue());
			fdObj.addFeedItems(fditem);

		}

		fdObjList.add(fdObj);

	}

	public String getFeed(String uri) throws Exception {

		CloseableHttpClient httpClient = HttpClients.createDefault();
		HttpGet getFeed = new HttpGet(uri);
		CloseableHttpResponse httpResponse = httpClient.execute(getFeed);
		HttpEntity httpEntity = httpResponse.getEntity();
		String xml = EntityUtils.toString(httpEntity);
		return xml;

	}

}
