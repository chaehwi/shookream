package com.chaehwi.shookream.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chaehwi.shookream.mapper.BoardMapper;
import com.chaehwi.shookream.vo.BoardVo;

@Service
public class BoardService {
	@Autowired
	private BoardMapper mapper;

	//게시판 등록 작업 
	public int insertCount(BoardVo board) {
		return mapper.insertBoard(board);
	}
	//게시판 등록 작업 끝 
	
	//공지 목록 
	public List<BoardVo> getBoardList(String keyword, int startRow, int listLimit , String type) {
		return mapper.selectBoardList(keyword, startRow, listLimit, type);
	} 
	//공지 목록 끝 

	//공지 목록 번호
	public int getBoardListCount(String keyword, String notice_type) {
		
		return mapper.selectBoardListCount(keyword,notice_type);
	}
	//공지목록 번호
	
	//공지 상세정보 & 공지 수정 
	public BoardVo getBoard(int notice_idx, boolean isUpdateReadCount) {
		int updateCount = mapper.updateReadcount(notice_idx);
		
		if(updateCount > 0) { 
			updateCount += 1;
		}
		return mapper.selectBoard(notice_idx);
	} //공지 상세정보 & 수정 끝

	//자주 묻는 질문 상세 
	public int updateReadcount(int notice_idx) {
		return mapper.updateReadcount(notice_idx);
	}
	//자주묻는 질문 상세 끝 
	
	//공지수정 pro
	public int modifyBoard(BoardVo board) {
		
		return mapper.updateBoard(board);
	}
	//공지 수정 pro끝 

	//공지 삭제 
	public boolean removeBoard(int notice_idx) {
		
		return mapper.deleteBoard(notice_idx);
	}
	//공지 삭제 끝 

	// 공지 카테고리 선택 ajax
	public List<BoardVo> getBoardJson(String notice_type ,String notice_category) {
		return mapper.selectBoardJson(notice_type, notice_category);
	}



}
		
		
	