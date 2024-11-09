# Requisitos Funcionais
    [x] Deve ser possível cadastrar um paciente
    [x] Deve ser possível cadastrar o endereço para um paciente
    [x] Deve ser possível cadastrar um dentista
    [ ] Deve ser possível criar um agendamento para o par paciente/dentista
    [ ] Deve ser possível cancelar um agendamento criado
    [ ] Deve ser possível confirmar um agendamento criado
    [ ] Deve ser possível finalizar um agendamento criado

# Regras de Negócio
### Sobre o status do agendamento
    [ ] Um agendamento deve ser criado com o status "pendente"
    [ ] Um agendamento "pendente" só pode ser "confirmado" ou "cancelado"
    [ ] Um agendamento "confirmado" só pode ser "finalizado" ou "cancelado"
    [ ] Um agendamento "cancelado" não pode mudar para outro status
    [ ] Um agendamento "finalizado" não pode mudar para outro status
### Sobre a criação do agendamento
    [ ] Um agendamento só pode ser marcado para uma data posterior ao momento de criação
    [ ] Um agendamento só pode ser marcado para uma data em que o dentista esteja disponível, ou seja, em que não haja outro agendamento para o mesmo dentista
