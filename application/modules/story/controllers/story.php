<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Story extends MY_Controller {

    public function __construct()
    {
        parent::__construct();

        $this->load->model('story_model', 'story');
    }

	public function index($page = 0)
	{
        // Page 1 is technically page zero
        if ($page == 1)
        {
            $page = 0;
        }

		// Get all stories
		$this->data['stories'] = $this->story->get_popular_stories(50, $page);

		$this->parser->parse('stories', $this->data);
	}

    public function submit()
    {
        $this->data['current_segment'] = "submit";

        if (!$this->input->post())
        {
            $this->parser->parse('add', $this->data);
        }
        else
        {
            $title = $this->input->post('title');
            $slug  = url_title($this->input->post('title'), '-', TRUE);
            $link  = $this->input->post('link', '');
            $text  = $this->input->post('text', '');

            $field_data = array(
                'user_id'       => 1,
                'title'         => $title,
                'slug'          => $slug,
                'external_link' => $link,
                'description'   => $text,
                'upvotes'       => 1,
                'created'       => time()
            );

            $insert = $this->story->insert($field_data);

            if ($insert)
            {
                $this->session->set_flashdata('success', lang('submission_success'));
                redirect('stories/new');
            }
        }    
    }

    public function new_stories($page = 0)
    {
        $this->data['current_segment'] = "new";

        // Page 1 is technically page zero
        if ($page == 1)
        {
            $page = 0;
        }

        // Get all stories
        $this->data['stories'] = $this->story->get_new_stories(50, $page);

        $this->parser->parse('stories', $this->data); 
    }
}

/* End of file story.php */