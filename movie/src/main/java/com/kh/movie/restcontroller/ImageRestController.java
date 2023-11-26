package com.kh.movie.restcontroller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.configuration.FileUploadProperties;
import com.kh.movie.dao.ActorDao;
import com.kh.movie.dao.ImageDao;
import com.kh.movie.dao.MovieDao;
import com.kh.movie.dto.ImageDto;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Tag(name = "이미지 관리", description = "이미지 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/rest/image")
public class ImageRestController {
	
	@Autowired
	private ActorDao actorDao;
	
	@Autowired
	private MovieDao movieDao;
	
	@Autowired
	private ImageDao imageDao;
	
	//프로필 업로드 & 다운로드 기능

			//초기 디렉터리 설정
			@Autowired
			private FileUploadProperties props;
			
			private File dir;
			
			@PostConstruct
			public void init() {
				dir = new File(props.getHome());
				dir.mkdirs();
			}
			
			
	@GetMapping("/actor/{actorNo}")
	public ResponseEntity<ByteArrayResource>downloadActorImage(@PathVariable int actorNo) throws IOException{
		
//		log.debug("actorNo={}",actorNo);
		
		ImageDto imageActorDto = actorDao.findActorImage(actorNo);
//		log.debug("imageActorDto={}",imageActorDto);
		
		File target = new File(dir,String.valueOf(imageActorDto.getImageNo()));
		byte[] data=FileUtils.readFileToByteArray(target);//실제파일정보 불러오기
		ByteArrayResource resource=new ByteArrayResource(data);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(imageActorDto.getImageSize())
				.header(HttpHeaders.CONTENT_TYPE,imageActorDto.getImageType())
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header("Content-Disposition","attachment;filename="+imageActorDto.getImageName())

				.body(resource);
	}
	
	@GetMapping("/movieMain/{movieNo}")
	public ResponseEntity<ByteArrayResource>downloadMovieMainImage(@PathVariable int movieNo) throws IOException{
		
//		log.debug("movieNo={}",movieNo);
		
		ImageDto movieMainImageDto = movieDao.findMainImage(movieNo);
		
//		log.debug("movieMainImageDto={}",movieMainImageDto);
		
		File target = new File(dir,String.valueOf(movieMainImageDto.getImageNo()));
		byte[] data=FileUtils.readFileToByteArray(target);//실제파일정보 불러오기
		ByteArrayResource resource=new ByteArrayResource(data);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(movieMainImageDto.getImageSize())
				.header(HttpHeaders.CONTENT_TYPE,movieMainImageDto.getImageType())
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header("Content-Disposition","attachment;filename="+movieMainImageDto.getImageName())
				
				.body(resource);
	}
	
	@GetMapping("/{imageNo}")
	public ResponseEntity<ByteArrayResource>downloadImage(@PathVariable int imageNo) throws IOException{
		
		ImageDto imageDto = imageDao.selectOne(imageNo);
		
		File target = new File(dir,String.valueOf(imageNo));
		byte[] data=FileUtils.readFileToByteArray(target);
		ByteArrayResource resource=new ByteArrayResource(data);
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(imageDto.getImageSize())
				.header(HttpHeaders.CONTENT_TYPE,imageDto.getImageType())
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header("Content-Disposition","attachment;filename="+imageDto.getImageName())
				
				.body(resource);
	}
	

	
	

	
}
