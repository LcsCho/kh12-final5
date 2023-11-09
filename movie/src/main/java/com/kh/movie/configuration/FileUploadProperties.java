package com.kh.movie.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

//application.properties에 있는 custom.fileupload 설정을 저장할 파일

@Data
@ConfigurationProperties(prefix ="custom.fileupload")
@Component
public class FileUploadProperties {
	private String home;
}
