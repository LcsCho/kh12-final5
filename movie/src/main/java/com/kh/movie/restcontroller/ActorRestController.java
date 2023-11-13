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
import com.kh.movie.vo.ActorUploadVO;
import com.kh.movie.vo.ActorViewVO;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
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
	
	@PostMapping(value = "/upload",consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public void insert(@ModelAttribute ActorUploadVO vo) throws IllegalStateException, IOException {
		
		ActorDto actorDto = vo.getActorDto();
		
		int actorNo = actorDao.sequence();
		
		actorDto.setActorNo(actorNo);
		actorDao.insert(actorDto);
		
		MultipartFile actorImage =vo.getActorImage();
		int imageNo = imageDao.sequence();
		File target = new File(dir,String.valueOf(imageNo));
		actorImage.transferTo(target);
		ImageDto imageDto = new ImageDto();
		imageDto.setImageNo(imageNo);
		imageDto.setImageName(actorImage.getOriginalFilename());
		imageDto.setImageSize(actorImage.getSize());
		imageDto.setImageType(actorImage.getContentType());	
		imageDao.insert(imageDto);
		
		actorDao.connectActorImage(actorNo,imageNo);
	}
	
	@DeleteMapping("/{actorNo}")
	public ResponseEntity<String> delete(@PathVariable int actorNo) {
		ImageDto imageDto = actorDao.findActorImage(actorNo);
//		log.debug("imageDto={}",imageDto);
		
		if(imageDto != null) {
			File target =new File(dir,String.valueOf(imageDto.getImageNo()));
			target.delete();//실제파일 삭제
			imageDao.delete(imageDto.getImageNo());//파일정보 삭제
			
		}
		boolean result = actorDao.delete(actorNo);
		if (result) {
			return ResponseEntity.status(200).build();
		}
		else return ResponseEntity.status(404).build();
	}
	
	@GetMapping("/findListByActorName/{actorName}")
	public List<ActorDto> findListByActorName(@PathVariable String actorName) {
		return actorDao.findListByActorName(actorName);
	}
	
	@GetMapping("/findByActorNo/{actorNo}")
	public ResponseEntity<ActorDto> findByActorNo(@PathVariable int actorNo){
		ActorDto actorDto = actorDao.findByActorNo(actorNo);
		ImageDto imageDto = actorDao.findActorImage(actorNo);
		log.debug("imageDto={}",imageDto);
//		log.debug("actorDto={}",actorDto);
		if(actorDto != null) {
			return ResponseEntity.ok(actorDto);
		}
		else {
			return ResponseEntity.notFound().build();
		}
	}
	
	@GetMapping("/actorList")
	public List<ActorViewVO> selectActorList() {
		return actorDao.selectActorList();
	}
	
	@PutMapping(value = "/editActor/{actorNo}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<String> edit(
	        @ModelAttribute ActorUploadVO vo,
	        @PathVariable int actorNo) throws IllegalStateException, IOException {
		ActorDto actorDto = vo.getActorDto();
		
		boolean result = actorDao.edit(actorNo, actorDto);
		MultipartFile actorImage =vo.getActorImage();
		log.debug("actorImage={}",actorImage);
		if(actorImage != null && !actorImage.isEmpty()) {
			ImageDto imageDto = actorDao.findActorImage(actorNo);
//			log.debug("imageDto={}",imageDto);
			if(imageDto != null) {
				imageDao.delete(imageDto.getImageNo());
				File target =new File(dir,String.valueOf(imageDto.getImageNo()));
				target.delete();
			}
			int imageNo = imageDao.sequence();
			File insertTarget = new File(dir,String.valueOf(imageNo));
			actorImage.transferTo(insertTarget);
			ImageDto insertDto = new ImageDto();
			insertDto.setImageNo(imageNo);
			insertDto.setImageName(actorImage.getOriginalFilename());
			insertDto.setImageSize(actorImage.getSize());
			insertDto.setImageType(actorImage.getContentType());	
			imageDao.insert(insertDto);
			
			actorDao.connectActorImage(actorNo, imageNo);
			
		}
		
		
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}
	
//	@PatchMapping("/{actorNo}")
//	public ResponseEntity<String> editUnit(@RequestBody ActorDto actorDto, @PathVariable int actorNo) {
//		if (actorDto.isEmpty()) return ResponseEntity.badRequest().build();
//		boolean result = actorDao.editUnit(actorNo, actorDto);
//		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
//	}
	

	
}