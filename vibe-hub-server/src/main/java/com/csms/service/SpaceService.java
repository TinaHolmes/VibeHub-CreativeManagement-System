package com.csms.service;

import com.csms.entity.Space;
import com.csms.repository.SpaceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SpaceService {

    @Autowired
    private SpaceRepository spaceRepository;

    public List<Space> getAllSpaces() {
        return spaceRepository.findAll();
    }
}
