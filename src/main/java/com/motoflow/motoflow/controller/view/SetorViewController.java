package com.motoflow.motoflow.controller.view;

import com.motoflow.motoflow.model.Setor;
import com.motoflow.motoflow.service.SetorService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/setores")
public class SetorViewController {

    private final SetorService setorService;

    public SetorViewController(SetorService setorService) {
        this.setorService = setorService;
    }

    @GetMapping
    public String listarSetores(Model model) {
        model.addAttribute("setores", setorService.findAll());
        return "setor/setor-list";
    }

    @GetMapping("/new")
    public String novoSetorForm(Model model) {
        model.addAttribute("setor", new Setor());
        return "setor/setor-form";
    }

    @PostMapping
    public String salvarSetor(@ModelAttribute Setor setor) {
        setorService.save(setor);
        return "redirect:/setores";
    }

    @GetMapping("/edit/{id}")
    public String editarSetor(@PathVariable Long id, Model model) {
        model.addAttribute("setor", setorService.findById(id));
        return "setor/setor-form";
    }

    @GetMapping("/delete/{id}")
    public String deletarSetor(@PathVariable Long id) {
        setorService.delete(id);
        return "redirect:/setores";
    }
}
