package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;


import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import model.HomeCheatSheetBean;
import repository.HomeCheatSheetRepository;

/**
 * Servlet implementation class DownloadPdfServlet
 */
@WebServlet("/DownloadPdfServlet")
public class DownloadPdfServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DownloadPdfServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		  try {

	            int id = Integer.parseInt(request.getParameter("id"));

	            HomeCheatSheetRepository repo =
	                new HomeCheatSheetRepository();

	            HomeCheatSheetBean sheet =
	                repo.findById(id);

	            if(sheet == null){
	                response.sendRedirect(
	                    request.getContextPath() + "/IndexServlet");
	                return;
	            }

	            response.setContentType("application/pdf");

	            response.setHeader(
	                "Content-Disposition",
	                "attachment; filename=\"" +
	                sheet.getTitle().replaceAll("[^a-zA-Z0-9]", "_") +
	                ".pdf\""
	            );

	            Document document =
	                new Document(PageSize.A4, 45, 45, 45, 45);

	            PdfWriter.getInstance(
	                document,
	                response.getOutputStream());

	            document.open();

	            BaseColor coral =
	                new BaseColor(244, 136, 130);

	            BaseColor pink =
	                new BaseColor(221, 155, 207);

	            BaseColor softPink =
	                new BaseColor(255, 247, 251);

	            BaseColor green =
	                new BaseColor(198, 250, 210);

	            Font titleFont =
	                FontFactory.getFont(
	                    FontFactory.HELVETICA_BOLD,
	                    30,
	                    coral);

	            Font metaFont =
	                FontFactory.getFont(
	                    FontFactory.HELVETICA,
	                    13,
	                    BaseColor.DARK_GRAY);

	            Font sectionFont =
	                FontFactory.getFont(
	                    FontFactory.HELVETICA_BOLD,
	                    18,
	                    coral);

	            Font keyFont =
	                FontFactory.getFont(
	                    FontFactory.HELVETICA_BOLD,
	                    12,
	                    pink);

	            Font valueFont =
	                FontFactory.getFont(
	                    FontFactory.HELVETICA,
	                    12,
	                    BaseColor.DARK_GRAY);

	            PdfPTable headerBox =
	                new PdfPTable(1);

	            headerBox.setWidthPercentage(100);

	            PdfPCell headerCell =
	                new PdfPCell();

	            headerCell.setPadding(25);
	            headerCell.setBorderColor(green);
	            headerCell.setBorderWidth(1.5f);
	            headerCell.setBackgroundColor(BaseColor.WHITE);

	            Paragraph title =
	                new Paragraph(sheet.getTitle(), titleFont);

	            title.setSpacingAfter(12);

	            headerCell.addElement(title);

	            headerCell.addElement(
	                new Paragraph(
	                    "By : " + sheet.getUsername(),
	                    metaFont));

	            if(sheet.getCategoryname() != null){
	                headerCell.addElement(
	                    new Paragraph(
	                        "Category : " + sheet.getCategoryname(),
	                        metaFont));
	            }

	            if(sheet.getTags() != null){
	                headerCell.addElement(
	                    new Paragraph(
	                        "Tags : " + sheet.getTags(),
	                        metaFont));
	            }

	            headerBox.addCell(headerCell);

	            document.add(headerBox);

	            document.add(new Paragraph(" "));

	            JSONArray sections =
	                new JSONArray(sheet.getNote());

	            PdfPTable grid =
	                new PdfPTable(2);

	            grid.setWidthPercentage(100);
	            grid.setSpacingBefore(20);
	            grid.setWidths(new float[]{1, 1});

	            for(int i = 0; i < sections.length(); i++){

	                JSONObject sec =
	                    sections.getJSONObject(i);

	                String sectionTitle =
	                    sec.optString("title", "General");

	                JSONArray items =
	                    sec.optJSONArray("items");

	                PdfPTable sectionTable =
	                    new PdfPTable(2);

	                sectionTable.setWidthPercentage(100);
	                sectionTable.setWidths(new float[]{1, 2});

	                PdfPCell sectionHeader =
	                    new PdfPCell(
	                        new Phrase(sectionTitle, sectionFont));

	                sectionHeader.setColspan(2);
	                sectionHeader.setPadding(14);
	                sectionHeader.setBackgroundColor(softPink);
	                sectionHeader.setBorderColor(new BaseColor(243, 213, 238));
	                sectionHeader.setBorderWidth(1);

	                sectionTable.addCell(sectionHeader);

	                if(items != null){

	                    for(int j = 0; j < items.length(); j++){

	                        JSONObject item =
	                            items.getJSONObject(j);

	                        String key =
	                            item.optString("k", "");

	                        String val =
	                            item.optString("v", "");

	                        PdfPCell keyCell =
	                            new PdfPCell(
	                                new Phrase(key, keyFont));

	                        keyCell.setPadding(12);
	                        keyCell.setBackgroundColor(softPink);
	                        keyCell.setBorderColor(new BaseColor(238, 238, 238));

	                        PdfPCell valueCell =
	                            new PdfPCell(
	                                new Phrase(val, valueFont));

	                        valueCell.setPadding(12);
	                        valueCell.setBackgroundColor(BaseColor.WHITE);
	                        valueCell.setBorderColor(new BaseColor(238, 238, 238));

	                        sectionTable.addCell(keyCell);
	                        sectionTable.addCell(valueCell);
	                    }
	                }

	                PdfPCell wrapper =
	                    new PdfPCell(sectionTable);

	                wrapper.setPadding(8);
	                wrapper.setBorder(Rectangle.NO_BORDER);

	                grid.addCell(wrapper);
	            }

	            if(sections.length() % 2 != 0){
	                PdfPCell empty =
	                    new PdfPCell(new Phrase(""));

	                empty.setBorder(Rectangle.NO_BORDER);

	                grid.addCell(empty);
	            }

	            document.add(grid);

	            document.close();

	        } catch(Exception e) {
	            e.printStackTrace();
	        }
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
