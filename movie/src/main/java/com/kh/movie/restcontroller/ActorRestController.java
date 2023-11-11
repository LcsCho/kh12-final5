package com.kh.movie.restcontroller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.movie.configuration.FileUploadProperties;
import com.kh.movie.dao.ActorDao;
import com.kh.movie.dao.ImageDao;
import com.kh.movie.dto.ActorDto;
import com.kh.movie.dto.ImageDto;
import com.kh.movie.vo.ActorImageUploadVO;
import com.kh.movie.vo.ActorViewVO;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "배우 관리", description = "배우 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/actor")
public class ActorRestController {
	
	@Autowired
	private ActorDao actorDao;
	
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
	
	@GetMapping("/")
	public List<ActorDto> list() {
		return actorDao.selectList();
	}
	
//	@PostMapping("/")
//	public void insert(@RequestBody ActorDto actorDto) {
//		actorDao.insert(actorDto);
//	}
	
	@DeleteMapping("/{actorNo}")
	public ResponseEntity<String> delete(@PathVariable int actorNo) {
		boolean result = actorDao.delete(actorNo);
		if (result) return ResponseEntity.status(200).build();
		else return ResponseEntity.status(404).build();
	}
	
	@GetMapping("/{actorName}")
	public List<ActorDto> find(@PathVariable String actorName) {
		return actorDao.selectList(actorName);
	}
	
	@GetMapping("/actorList")
	public List<ActorViewVO> selectActorList() {
		return actorDao.selectActorList();
	}
	
	@PutMapping("/{actorNo}")
	public ResponseEntity<String> edit(@RequestBody ActorDto actorDto, @PathVariable int actorNo) {
		boolean result = actorDao.edit(actorNo, actorDto);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}
	
	@PatchMapping("/{actorNo}")
	public ResponseEntity<String> editUnit(@RequestBody ActorDto actorDto, @PathVariable int actorNo) {
		if (actorDto.isEmpty()) return ResponseEntity.badRequest().build();
		boolean result = actorDao.editUnit(actorNo, actorDto);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}
	
	@PostMapping(value = "/",consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public void insert(@ModelAttribute ActorImageUploadVO vo) throws IllegalStateException, IOException {
		
		ActorDto actorDto = vo.getActorDto();
		
		int actorNo = actorDao.sequence();
		
		actorDto.setActorNo(actorNo);
		actorDao.insert(actorDto);
		
		MultipartFile attach =vo.getAttach();
		int imageNo = imageDao.sequence();
		File target = new File(dir,String.valueOf(imageNo));
		attach.transferTo(target);
		ImageDto imageDto = new ImageDto();
		imageDto.setImageNo(imageNo);
		imageDto.setImageName(attach.getOriginalFilename());
		imageDto.setImageSize(attach.getSize());
		imageDto.setImageType(attach.getContentType());	
		imageDao.insert(imageDto);
		
		actorDao.connectActorImage(actorNo,imageNo);
	}
	
}
