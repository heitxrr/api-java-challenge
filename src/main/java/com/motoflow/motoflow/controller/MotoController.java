
package com.motoflow.motoflow.controller;

import com.motoflow.motoflow.model.Moto;
import com.motoflow.motoflow.service.MotoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/motos")
public class MotoController {

    private final MotoService motoService;

    public MotoController(MotoService motoService) {
        this.motoService = motoService;
    }

    @GetMapping
    public List<Moto> getAll() {
        return motoService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Moto> getById(@PathVariable Long id) {
        return motoService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Moto create(@RequestBody Moto moto) {
        return motoService.save(moto);
    }

    @GetMapping("/setor/{idSetor}")
    public List<Moto> getMotosBySetor(@PathVariable Long idSetor) {
        return motoService.findMotosBySetor(idSetor);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Moto> update(@PathVariable Long id, @RequestBody Moto moto) {
        return motoService.findById(id)
                .map(existing -> {
                    moto.setId(id);
                    return ResponseEntity.ok(motoService.save(moto));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        if (motoService.findById(id).isPresent()) {
            motoService.delete(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
