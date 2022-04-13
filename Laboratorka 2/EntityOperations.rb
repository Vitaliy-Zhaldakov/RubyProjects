class EntityOperations

  def add_entity(entity)
    @list << entity
  end

  def select_entity(index)
    @selectedEntity = index
  end

  def delete_entity
    @list.delete_at(@selectedEntity)
    @selectedEntity = nil
  end

  def get_selected_entity
    @list[@selectedEntity]
  end

  def change_selected_entity(newValue)
    @list[@selectedEntity] = newValue
  end
end
