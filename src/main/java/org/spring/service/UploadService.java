package org.spring.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class UploadService {
	private final ServletContext servletContext;

	public UploadService(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	public String handleSaveUploadFile(MultipartFile file, String targetFolder) {
		if (file.isEmpty())
			return "";
		String rootPath = this.servletContext.getRealPath("/res/images");
		String finalName = "";
		try {
			byte[] bytes = file.getBytes();

			File dir = new File(rootPath + File.separator + targetFolder);
			if (!dir.exists())
				dir.mkdirs();

			// Create the file on server

			finalName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();

			File serverFile = new File(dir.getAbsolutePath() + File.separator + finalName);
			// uuid

			BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
			stream.write(bytes);
			stream.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return finalName;
	}

}
