package com.motoflow.motoflow.controller.view;

import com.motoflow.motoflow.model.Movimentacao;
import com.motoflow.motoflow.service.MovimentacaoService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/movimentacoes")
public class MovimentacaoViewController {

    private final MovimentacaoService movimentacaoService;

    public MovimentacaoViewController(MovimentacaoService movimentacaoService) {
        this.movimentacaoService = movimentacaoService;
    }

    @GetMapping
    public String listarMovimentacoes(Model model) {
        model.addAttribute("movimentacoes", movimentacaoService.findAll());
        return "movimentacao/movimentacao-list";
    }

    @GetMapping("/new")
    public String novaMovimentacaoForm(Model model) {
        model.addAttribute("movimentacao", new Movimentacao());
        return "movimentacao/movimentacao-form";
    }

    @PostMapping
    public String salvarMovimentacao(@ModelAttribute Movimentacao movimentacao) {
        movimentacaoService.save(movimentacao);
        return "redirect:/movimentacoes";
    }

    @GetMapping("/edit/{id}")
    public String editarMovimentacao(@PathVariable Long id, Model model) {
        model.addAttribute("movimentacao", movimentacaoService.findById(id));
        return "movimentacao/movimentacao-form";
    }

    @GetMapping("/delete/{id}")
    public String deletarMovimentacao(@PathVariable Long id) {
        movimentacaoService.delete(id);
        return "redirect:/movimentacoes";
    }
}
