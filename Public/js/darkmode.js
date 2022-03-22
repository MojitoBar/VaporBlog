document.addEventListener('DOMContentLoaded', function(){
    //다크모드 토글
    if(document.querySelector('.darkmode')){
        if(localStorage.getItem("darkmode") == 'on'){
            //다크모드 켜기
            document.body.dataset.darkmode='on';
            document.querySelector('#toggle-radio-dark').checked = true;
        }
        //다크모드 이벤트 핸들러
        document.querySelector('.darkmode').addEventListener("click", e=>{
            if(e.target.classList.contains('todark')){
                document.body.dataset.darkmode='on';
                localStorage.setItem("darkmode", "on");
            }else if(e.target.classList.contains('tolight')){
                document.body.dataset.darkmode='off';
                localStorage.setItem("darkmode", "off");
            }
        },false);
    }else{
        localStorage.removeItem("darkmode");
    }
})


window.addEventListener('DOMContentLoaded', () => {

    const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            const id = entry.target.getAttribute('id');
            if (entry.intersectionRatio > 0) {
                document.querySelector(`a[href="#${id}"] div`).parentElement.classList.add('active');
            } else {
                document.querySelector(`div a[href="#${id}"] div`).parentElement.classList.remove('active');
            }
        });
    });

    // Track all sections that have an `id` applied
    document.querySelectorAll('section[id]').forEach((section) => {
        observer.observe(section);
    });
    
});
