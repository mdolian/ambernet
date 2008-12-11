class Secrets < Application
  # provides :xml, :yaml, :js

  def index
    @secrets = Secret.all
    display @secrets
  end

  def show(id)
    @secret = Secret.get(id)
    raise NotFound unless @secret
    display @secret
  end

  def new
    only_provides :html
    @secret = Secret.new
    display @secret
  end

  def edit(id)
    only_provides :html
    @secret = Secret.get(id)
    raise NotFound unless @secret
    display @secret
  end

  def create(secret)
    @secret = Secret.new(secret)
    if @secret.save
      redirect resource(@secret), :message => {:notice => "Secret was successfully created"}
    else
      message[:error] = "Secret failed to be created"
      render :new
    end
  end

  def update(id, secret)
    @secret = Secret.get(id)
    raise NotFound unless @secret
    if @secret.update_attributes(secret)
       redirect resource(@secret)
    else
      display @secret, :edit
    end
  end

  def destroy(id)
    @secret = Secret.get(id)
    raise NotFound unless @secret
    if @secret.destroy
      redirect resource(:secrets)
    else
      raise InternalServerError
    end
  end

end # Secrets
