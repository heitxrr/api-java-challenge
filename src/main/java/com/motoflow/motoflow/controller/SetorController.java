package com.motoflow.motoflow.controller;

import com.motoflow.motoflow.model.Setor;
import com.motoflow.motoflow.service.SetorService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/setores")
public class SetorController {

    private final SetorService setorService;

    public SetorController(SetorService setorService) {
        this.setorService = setorService;
    }

    @GetMapping
    public List<Setor> getAll() {
        return setorService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Setor> getById(@PathVariable Long id) {
        return setorService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Setor create(@RequestBody Setor setor) {
        return setorService.save(setor);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Setor> update(@PathVariable Long id, @RequestBody Setor setor) {
        return setorService.findById(id)
                .map(existing -> {
                    setor.setId(id);
                    return ResponseEntity.ok(setorService.save(setor));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        if (setorService.findById(id).isPresent()) {
            setorService.delete(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
